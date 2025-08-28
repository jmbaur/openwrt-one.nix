{ linuxKernel, linux_latest }:
linuxKernel.manualConfig {
  inherit (linux_latest) src version modDirVersion;
  configfile = ./kernel.config;
  kernelPatches =
    map
      (patch: {
        name = builtins.baseNameOf patch;
        inherit patch;
      })
      [
        ./0001-complete-mt7981-dts.patch
        ./0002-Complete-openwrt-one-devicetree.patch
      ];
}
