{
  armTrustedFirmwareTools,
  buildUBoot,
  lib,
  xxd,

  # Build for loading over UART with mtk_uartboot. Ignores any environment
  # stored in flash and never autoboots, so it always drops to a prompt.
  ramBoot ? false,
}:

(buildUBoot {
  # TODO(jared): make boot device customizable (nor/nand/etc)
  defconfig = "mt7981_openwrt-one-spi-nand_defconfig";

  extraConfig = lib.optionalString ramBoot ''
    # CONFIG_ENV_IS_IN_UBI is not set
    CONFIG_ENV_IS_NOWHERE=y
    CONFIG_BOOTDELAY=-1
    CONFIG_SYS_PROMPT="bootstrap> "
  '';

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
