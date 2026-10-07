"""Flash an OpenWrt One's SPI-NAND over its serial console.

Uses mtk_uartboot to start BL2 + U-Boot from RAM via the BootROM's UART
download mode, then drives that U-Boot to receive each image and write it to
its MTD partition. The bootloaders are small enough to send over the serial
console with XMODEM; the (likely much larger) OS image is loaded from a
FAT-formatted USB stick. Only the SPI-NAND is written; the SPI-NOR (which holds the factory wifi calibration
data) is never touched.
"""

import argparse
import io
import os
import re
import subprocess
import sys
import tarfile
import tempfile
import time
import zlib

import pexpect
import serial
from pexpect import fdpexpect
from xmodem import XMODEM

# Must match the spi-nand fixed-partitions in the U-Boot and kernel device
# trees.
PARTITION_SIZES = {
    "bl2": 0x100000,
    "fip": 0x200000,
    "ubi": 0xFA80000,
}

# The image in the bootstrapImages tarball for each partition, in the order
# they're flashed.
IMAGES = {
    "bl2": "nand/bl2.img",
    "fip": "nand/fip.bin",
    "ubi": "nand/ubi.img",
}

CONSOLE_BAUD = 115200
PROMPT = b"bootstrap> "
NAND_PAGE_SIZE = 2048
LOAD_ADDR = 0x46000000
# Far enough above LOAD_ADDR to hold a full ubi partition.
VERIFY_ADDR = 0x56000000


# How long a command can go without printing anything before we say we're
# still waiting on it.
QUIET_INTERVAL = 10


def log(msg):
    print(f"\n\033[1m==> {msg}\033[0m", flush=True)


class Console:
    def __init__(self, port):
        self.ser = serial.Serial(port, CONSOLE_BAUD, timeout=0.1, exclusive=True)
        # pexpect reads the port directly, and proxies everything the board
        # prints to stdout.
        self.child = fdpexpect.fdspawn(self.ser.fileno())
        self.child.logfile_read = sys.stdout.buffer

    def send(self, data):
        self.child.send(data)

    def flush_input(self):
        self.ser.reset_input_buffer()
        self.child.buffer = b""

    def expect(self, patterns, timeout, what):
        """Wait for one of the regexes `patterns`, returning its index.

        `what` describes what we're waiting for, for progress and errors.
        """
        start = time.monotonic()
        seen = len(self.child.buffer)
        while (remaining := timeout - (time.monotonic() - start)) > 0:
            try:
                return self.child.expect(
                    patterns, timeout=min(QUIET_INTERVAL, remaining)
                )
            except pexpect.TIMEOUT:
                elapsed = time.monotonic() - start
                if len(self.child.buffer) == seen and elapsed < timeout:
                    print(f"\n  ... still waiting for {what} ({elapsed:.0f}s)", flush=True)
                seen = len(self.child.buffer)
            except pexpect.EOF:
                raise RuntimeError(f"serial port closed while waiting for {what}")
        raise TimeoutError(f"timed out after {timeout}s waiting for {what}")

    def wait_for_prompt(self, timeout):
        deadline = time.monotonic() + timeout
        while time.monotonic() < deadline:
            self.send(b"\r")
            try:
                return self.expect([re.escape(PROMPT)], 1, "the U-Boot prompt")
            except TimeoutError:
                pass
        raise TimeoutError(
            f"timed out after {timeout}s waiting for the U-Boot prompt"
        )

    def run(self, cmd, timeout=10):
        """Run a U-Boot command, returning its output; raises on failure."""
        self.flush_input()
        self.send(f"{cmd}; echo rc=$?\r".encode())
        self.expect(
            [rb"rc=(\d+)\r?\n" + re.escape(PROMPT)], timeout, f"`{cmd}` to finish"
        )
        if int(self.child.match[1]) != 0:
            raise RuntimeError(f"`{cmd}` failed")
        return self.child.before.decode(errors="replace")

    def loadx(self, data, baud):
        """Send `data` to LOAD_ADDR with U-Boot's `loadx`."""
        self.flush_input()
        if baud == CONSOLE_BAUD:
            self.send(f"loadx {LOAD_ADDR:#x}\r".encode())
        else:
            self.send(f"loadx {LOAD_ADDR:#x} {baud}\r".encode())
            self.expect([rb"press ENTER"], 10, f"U-Boot to switch to {baud} baud")
            # U-Boot switches baud shortly after printing the message.
            time.sleep(0.2)
            self.ser.baudrate = baud
            self.send(b"\r")
        self.expect(
            [rb"Ready for binary[^\n]*\n"], 10, "U-Boot to start receiving XMODEM"
        )

        total = len(data) // 1024

        def getc(size, timeout=1):
            # The first "C" from U-Boot may already be in pexpect's buffer.
            buf = self.child.buffer[:size]
            self.child.buffer = self.child.buffer[size:]
            self.ser.timeout = timeout
            buf += self.ser.read(size - len(buf))
            return buf or None

        def putc(buf, timeout=1):
            return self.ser.write(buf)

        def progress(_total, success, errors):
            if success % 256 == 0 or success == total:
                pct = 100 * success // total
                print(
                    f"\r  {success}/{total} KiB ({pct}%), {errors} retries",
                    end="",
                    flush=True,
                )

        modem = XMODEM(getc, putc, mode="xmodem1k")
        ok = modem.send(io.BytesIO(data), retry=32, callback=progress, quiet=True)
        self.ser.timeout = 0.1
        print()
        if not ok:
            raise RuntimeError("XMODEM transfer failed")

        if baud != CONSOLE_BAUD:
            self.expect(
                [rb"press ESC"], 10, f"U-Boot to switch back to {CONSOLE_BAUD} baud"
            )
            time.sleep(0.2)
            self.ser.baudrate = CONSOLE_BAUD
            self.send(b"\x1b")
        self.expect(
            [re.escape(PROMPT)], 10, "the U-Boot prompt after the XMODEM transfer"
        )

    def getenv(self, name):
        out = self.run(f"printenv {name}")
        return re.search(rf"^{name}=(.*?)\r?$", out, re.MULTILINE)[1]

    def crc32(self, addr, size):
        out = self.run(f"crc32 {addr:#x} {size:#x}")
        return int(re.search(r"==> ([0-9a-f]{8})", out)[1], 16)


def load_usb(console, name, data, dev, path):
    log(f"Loading {path} from USB storage device {dev}")
    console.run("usb start", timeout=60)
    console.run(f"load usb {dev} {LOAD_ADDR:#x} {path}", timeout=600)
    filesize = int(console.getenv("filesize"), 16)
    if not 0 <= len(data) - filesize < NAND_PAGE_SIZE:
        raise RuntimeError(
            f"{path} on the USB stick is {filesize:#x} bytes, expected "
            f"{len(data):#x}; is it from this build?"
        )
    # Apply the same padding flash() does.
    if filesize < len(data):
        console.run(
            f"mw.b {LOAD_ADDR + filesize:#x} 0xff {len(data) - filesize:#x}; "
            f"setenv filesize {len(data):x}"
        )


def check_partitions(console):
    out = console.run("mtd list")
    found = {
        name: int(end, 16) - int(start, 16)
        for start, end, name in re.findall(
            r"0x([0-9a-f]+)-0x([0-9a-f]+) : \"(\w+)\"", out
        )
    }
    for name, size in PARTITION_SIZES.items():
        if name not in found:
            raise RuntimeError(f"U-Boot has no {name!r} partition")
        if found[name] != size:
            raise RuntimeError(
                f"expected partition {name!r} of size {size:#x}, "
                f"U-Boot reports {found[name]:#x}"
            )


def flash(console, name, path, load):
    with open(path, "rb") as f:
        data = f.read()
    # Pad to a whole number of NAND pages; this is also a multiple of the
    # XMODEM-1K block size, so XMODEM never adds its own padding.
    data += b"\xff" * (-len(data) % NAND_PAGE_SIZE)
    if len(data) > PARTITION_SIZES[name]:
        raise RuntimeError(f"{name} image does not fit in its partition")

    log(f"{name}: loading {len(data)} bytes")
    load(name, data)
    filesize = int(console.getenv("filesize"), 16)
    if filesize != len(data):
        raise RuntimeError(
            f"U-Boot received {filesize:#x} bytes, expected {len(data):#x}"
        )
    if console.crc32(LOAD_ADDR, len(data)) != zlib.crc32(data):
        raise RuntimeError(
            f"{name}: CRC mismatch after transfer (if loading from USB, is "
            "the image on the stick from this build?)"
        )

    log(f"{name}: erasing and writing")
    console.run(f"mtd erase {name}", timeout=120)
    console.run(f"mtd write {name} {LOAD_ADDR:#x} 0 {len(data):#x}", timeout=600)

    log(f"{name}: verifying")
    console.run(f"mtd read {name} {VERIFY_ADDR:#x} 0 {len(data):#x}", timeout=600)
    if console.crc32(VERIFY_ADDR, len(data)) != zlib.crc32(data):
        raise RuntimeError(f"{name}: CRC mismatch after readback")


def run():
    assert __doc__ is not None
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument(
        "-s",
        "--serial",
        default="/dev/ttyACM0",
        help="serial port (default: %(default)s, the board's USB-C console)",
    )
    parser.add_argument(
        "-b",
        "--baud",
        type=int,
        default=CONSOLE_BAUD,
        help="baud rate for loading images over the serial console, both by "
        "mtk_uartboot and with XMODEM. The board's USB-C console has been "
        "seen to corrupt data after switching to 460800 (default: "
        "%(default)s)",
    )
    parser.add_argument(
        "--images",
        required=True,
        metavar="TARBALL",
        help="tarball of images to flash, from "
        "config.system.build.bootstrapImages",
    )
    parser.add_argument(
        "--usb-dev",
        default="0",
        help="U-Boot USB storage device, optionally with a partition, e.g. "
        "0:1 (default: %(default)s, the first FAT partition found)",
    )
    parser.add_argument(
        "--usb-path",
        default="ubi.img",
        help="path of the OS image on the USB stick (default: %(default)s)",
    )
    parser.add_argument(
        "--no-uartboot",
        action="store_true",
        help="skip mtk_uartboot, the bootstrap U-Boot is already running",
    )
    args = parser.parse_args()

    with tempfile.TemporaryDirectory() as images:
        with tarfile.open(args.images) as tar:
            tar.extractall(images, filter="data")
        bootstrap(args, images)


def bootstrap(args, images):
    """Flash every partition from the unpacked `images` tarball."""
    if not args.no_uartboot:
        log("Power on (or reset) the board now")
        subprocess.run(
            [
                "mtk_uartboot",
                "--serial",
                args.serial,
                "--payload",
                os.path.join(images, "ram/bl2.bin"),
                "--fip",
                os.path.join(images, "ram/fip.bin"),
                "--aarch64",
                "--brom-load-baudrate",
                str(args.baud),
                "--bl2-load-baudrate",
                str(args.baud),
            ],
            check=True,
        )

    console = Console(args.serial)
    log("Waiting for U-Boot")
    console.wait_for_prompt(60)
    check_partitions(console)

    def load(name, data):
        if name == "ubi":
            load_usb(console, name, data, args.usb_dev, args.usb_path)
        else:
            console.loadx(data, args.baud)

    for name, path in IMAGES.items():
        flash(console, name, os.path.join(images, path), load)

    log("Done, power-cycle the board to boot the new images")


def main():
    try:
        run()
    except (
        OSError,
        RuntimeError,
        TimeoutError,
        subprocess.CalledProcessError,
    ) as e:
        sys.stdout.flush()
        print(f"\nerror: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
