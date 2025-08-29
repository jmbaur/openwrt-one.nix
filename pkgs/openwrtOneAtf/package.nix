{
  bootDevice ? "spim-nand",
  buildArmTrustedFirmware,
  dtc,
  fetchFromGitHub,
  lib,
  openssl,
  openwrtOneUBoot,
  ubootTools,
}:

buildArmTrustedFirmware rec {
  platform = "mt7981";

  version = builtins.substring 0 7 src.rev;

  # mt7981 not in upstream ATF yet
  src = fetchFromGitHub {
    owner = "mtk-openwrt";
    repo = "arm-trusted-firmware";
    rev = "78a0dfd927bb00ce973a1f8eb4079df0f755887a"; # mtksoc-20250711 branch
    hash = "sha256-m9ApkBVf0I11rNg68vxofGRJ+BcnlM6C+Zrn8TfMvbY=";
  };

  strictDeps = true;
  enableParallelBuilding = true;

  extraMakeFlags = [
    "BL33=${openwrtOneUBoot}/u-boot.bin"
    "BOOT_DEVICE=${bootDevice}" # defines where the FIP image lives
    "DRAM_USE_DDR4=1"
    "USE_MKIMAGE=1"
    "bl2"
    "fip"
  ]
  ++ lib.optionals (bootDevice == "ram") [
    "RAM_BOOT_UART_DL=1"
  ];

  nativeBuildInputs = [
    dtc
    openssl
    ubootTools
  ];

  filesToInstall = [
    "build/${platform}/release/fip.bin"
  ]
  ++ (
    if bootDevice == "ram" then
      [ "build/${platform}/release/bl2.bin" ]
    else
      [ "build/${platform}/release/bl2.img" ]
  );

  extraMeta.platforms = [ "aarch64-linux" ];
}
