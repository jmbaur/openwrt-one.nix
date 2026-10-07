# openwrt-one.nix

[mixos](https://github.com/jmbaur/mixos) configuration for the [OpenWrt One](https://openwrt.org/toh/openwrt/one).

## Bootstrapping a board

`nix run github:jmbaur/openwrt-one.nix#openwrt-one-bootstrap` flashes everything from your MixOS configuration on SPI-NAND of your openwrt-one. If you don't yet have a configuration, you can test it out like so:

```console
$ # assumes you have a USB stick at /dev/sda
$ printf 'label: gpt\nname=OPENWRT\n' | sudo sfdisk --wipe always --wipe-partitions always /dev/sda
$ sudo mkfs.vfat -F 32 -n OPENWRT /dev/sda1
$ sudo mount --mkdir /dev/sda1 /mnt
$ sudo cp "$(nix build --no-link --print-out-paths github:jmbaur/openwrt-one.nix#mixosConfigurations.example.config.system.build.ubiImage)/ubi.img" /mnt/
$ sudo umount /mnt
$ # assumes you have plugged USB stick into device
$ images="$(nix build --no-link --print-out-paths github:jmbaur/openwrt-one.nix#mixosConfigurations.example.config.system.build.bootstrapImages)"
$ nix run github:jmbaur/openwrt-one.nix#openwrt-one-bootstrap -- --images "$images"
```
