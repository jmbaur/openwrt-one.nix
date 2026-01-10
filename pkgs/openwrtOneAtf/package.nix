{
  bootDevice ? "spim-nand",
  dtc,
  pkgsBuildBuild,
  fetchFromGitHub,
  lib,
  openssl,
  openwrtOneUBoot,
  ubootTools,
  stdenv,
}:

stdenv.mkDerivation (
  finalAttrs:
  let
    platform = "mt7981";
  in
  {
    pname = "openwrt-one-arm-trusted-firmware";
    version = builtins.substring 0 7 finalAttrs.src.rev;

    # mt7981 not in upstream ATF yet
    src = fetchFromGitHub {
      owner = "mtk-openwrt";
      repo = "arm-trusted-firmware";
      rev = "78a0dfd927bb00ce973a1f8eb4079df0f755887a"; # mtksoc-20250711 branch
      hash = "sha256-m9ApkBVf0I11rNg68vxofGRJ+BcnlM6C+Zrn8TfMvbY=";
    };

    strictDeps = true;
    enableParallelBuilding = true;

    makeFlags = [
      "PLAT=${platform}"
      "BL33=${openwrtOneUBoot}/u-boot.bin"
      "BOOT_DEVICE=${bootDevice}" # defines where the FIP image lives
      "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
      # Make the new toolchain guessing (from 2.11+) happy
      "CC=${stdenv.cc.targetPrefix}cc"
      "LD=${stdenv.cc.targetPrefix}cc"
      "AS=${stdenv.cc.targetPrefix}cc"
      "OC=${stdenv.cc.targetPrefix}objcopy"
      "OD=${stdenv.cc.targetPrefix}objdump"
      "DRAM_USE_DDR4=1"
      "USE_MKIMAGE=1"
      "bl2"
      "fip"
    ]
    ++ lib.optionals (bootDevice == "ram") [
      "RAM_BOOT_UART_DL=1"
    ];

    hardeningDisable = [ "all" ];
    dontStrip = true;

    depsBuildBuild = [
      pkgsBuildBuild.stdenv.cc
      dtc
      openssl

      # TODO(jared): ubootTools currently doesn't build for
      # pkgsBuildHost, use in depsBuildBuild for now.
      ubootTools
    ];

    installPhase = ''
      runHook preInstall
      install -Dt $out build/${platform}/release/fip.bin
      install -Dt $out ${
        if bootDevice == "ram" then
          "build/${platform}/release/bl2.bin"
        else
          "build/${platform}/release/bl2.img"
      }
      runHook postInstall
    '';

    meta.platforms = [ "aarch64-linux" ];
  }
)
