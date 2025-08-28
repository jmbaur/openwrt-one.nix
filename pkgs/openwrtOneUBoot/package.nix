{
  armTrustedFirmwareTools,
  buildUBoot,
  fetchpatch,
  xxd,
}:

(buildUBoot {
  # TODO(jared): make boot device customizable (nor/nand/etc)
  defconfig = "mt7981_openwrt-one-spi-nand_defconfig";

  filesToInstall = [
    ".config"
    "u-boot.bin"
  ];

  patches = [ ./0001-Add-openwrt-one.patch ];
}).overrideAttrs
  (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
      armTrustedFirmwareTools
      xxd
    ];
  })
