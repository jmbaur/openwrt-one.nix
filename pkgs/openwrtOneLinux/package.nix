{
  fetchFromGitHub,
  linuxKernel,
  linux_6_12,
}:
let
  openwrt = fetchFromGitHub {
    owner = "openwrt";
    repo = "openwrt";
    rev = "e49a2192e5ee6812f9e2bd44d85961406bcb0928";
    hash = "sha256-r5EgPtBbUc/SV/DU2sHh1x1ntpctMKau8c0a2l1ze+o=";
  };
in
linuxKernel.manualConfig {
  inherit (linux_6_12) src version modDirVersion;
  configfile = ./kernel.config;
  kernelPatches = [
    rec {
      name = builtins.baseNameOf patch;
      patch = ./complete-openwrt-one.patch;
    }
    rec {
      name = builtins.baseNameOf patch;
      patch = ./25ge.patch;
    }
  ]
  ++
    map
      (name: {
        inherit name;
        patch = "${openwrt}/target/linux/mediatek/patches-6.12/${name}";
      })
      [
        "010-v6.14-pinctrl-mediatek-add-support-for-MTK_PULL_PD_TYPE.patch"
        "011-v6.14-pinctrl-mediatek-add-MT7988-pinctrl-driver.patch"
        "012-v6.14-pinctrl-mediatek-Drop-mtk_pinconf_bias_set_pd.patch"
        "050-v6.16-phy-mediatek-xsphy-support-type-switch-by-pericfg.patch"
        "117-complete-mt7981b-dtsi.patch"
        "121-hack-spi-nand-1b-bbm.patch"
        "200-phy-phy-mtk-tphy-Add-hifsys-support.patch"
        "255-clk-mediatek-mt7988-infracfg-SPI0-clocks-are-not-critical.patch"
        "320-hwrng-add-driver-for-MediaTek-TRNG-SMC.patch"
        # "330-snand-mtk-bmt-support.patch"
        # "331-mt7622-rfb1-enable-bmt.patch"
        # "340-mtd-spinand-Add-support-for-the-Fidelix-FM35X1GA.patch"
        "350-21-cpufreq-mediatek-Add-support-for-MT7988.patch"
        "400-crypto-add-eip97-inside-secure-support.patch"
        "401-crypto-fix-eip97-cache-incoherent.patch"
        "410-bt-mtk-serial-fix.patch"
        "411-mtd-spinand-fix-support-for-FORESEE.patch"
        "431-drivers-spi-mt65xx-Move-chip_config-to-driver-s-priv.patch"
        "432-drivers-spi-Add-support-for-dynamic-calibration.patch"
        "433-drivers-spi-mem-Add-spi-calibration-hook.patch"
        "434-drivers-spi-mt65xx-Add-controller-s-calibration-para.patch"
        "435-drivers-mtd-spinand-Add-calibration-support-for-spin.patch"
        "436-drivers-mtd-spi-nor-Add-calibration-support-for-spi-.patch"
        # "450-nvmem-add-layout-for-Adtran-devices.patch"
        # NOTE: 700 and 701 replaced with ./25ge.patch
        # "700-net-phy-mediatek-Add-2.5Gphy-firmware-dt-bindings-an.patch"
        # "701-net-phy-mediatek-add-driver-for-built-in-2.5G-ethern.patch"
        "710-pci-pcie-mediatek-add-support-for-coherent-DMA.patch"
        "732-net-phy-mxl-gpy-don-t-use-SGMII-AN-if-using-phylink.patch"
        "734-net-phy-add-Airoha-EN8801SC-PHY.patch"
        # "736-net-pcs-mtk_usxgmii-add-polarity-control.patch"
        # "737-net-dsa-add-Airoha-AN8855.patch"
        # "739-net-add-negotiation-of-in-band-capabilities.patch"
        # "920-block-partitions-msdos-add-OF-node-by-partition-numb.patch"
        "930-spi-mt65xx-enable-sel-clk.patch"
        "940-net-ethernet-mtk_wed-rename-mtk_wed_get_memory_regio.patch"
        "942-net-ethernet-mtk_wed-move-cpuboot-in-a-dedicated-dts.patch"
        "943-net-ethernet-mtk_wed-move-ilm-a-dedicated-dts-node.patch"
        "944-net-ethernet-mtk_wed-move-dlm-a-dedicated-dts-node.patch"
      ];
}
