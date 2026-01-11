{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (builtins) listToAttrs;
  inherit (lib.attrsets) unionOfDisjoint;
  inherit (lib)
    imap1
    mkDefault
    mkEnableOption
    mkIf
    toHexString
    ;

  ubootEnvSize = 124 * 1024; # CONFIG_ENV_SIZE

  cfg = config.hardware.openwrt-one;
in
{
  options.hardware.openwrt-one = {
    enable = mkEnableOption "OpenWRT One hardware support";
  };

  config = mkIf cfg.enable {
    nixpkgs.hostPlatform = mkDefault "aarch64-linux";

    boot.kernelPackages = pkgs.linuxPackagesFor pkgs.openwrtOneLinux;

    boot.requiredKernelConfig = [ "FW_LOADER_COMPRESS_XZ" ];

    boot.kernelModules = [
      "air_en8811h"
      "mt7915e"
    ];

    init.watchdog = {
      action = "respawn";
      process = toString [
        "/bin/watchdog"
        "-F"
        "/dev/watchdog"
      ];
    };

    boot.firmware = [
      (pkgs.runCommand "mediatek-and-wireless-firmware" { } ''
        mkdir -p $out/lib/firmware/{mediatek,airoha}

        for dir in mediatek airoha; do
          cp -r ${pkgs.linux-firmware}/lib/firmware/$dir/* $out/lib/firmware/$dir/
        done
        cp ${pkgs.wireless-regdb}/lib/firmware/regulatory.db* $out/lib/firmware
        cp ${
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/openwrt/mt76/c63db0fcadb88680b35bec202b5142cfd016c10f/firmware/mt7981_eeprom_mt7976_dbdc.bin";
            hash = "sha256-lyOOIiiJenOINwYEy+cXXgv6DMNfVitkMwsSwarut1E=";
          }
        } $out/lib/firmware/mediatek/mt7981_eeprom_mt7976_dbdc.bin

        # Find and fix broken symlinks
        while read -r symlink; do
          resolved=$(readlink --canonicalize-missing $symlink)
          if [[ -f $resolved ]]; then
            continue
          fi

          install -Dm0444 ''${resolved/$out/${pkgs.linux-firmware}} $out''${resolved/$out/}
        done < <(find $out/lib/firmware -type l)
      '')
    ];

    system.build.fitImage = pkgs.callPackage (
      {
        dtc,
        runCommand,
        ubootTools,
        xz,
      }:
      runCommand "mixos.itb"
        {
          # TODO(jared): ubootTools fails for pkgsBuildHost, just put
          # in depsBuildBuild for now.
          depsBuildBuild = [
            dtc
            ubootTools
            xz
          ];
        }
        ''
          install -m0644 ${config.boot.kernelPackages.kernel}/${pkgs.stdenv.hostPlatform.linux-kernel.target} kernel
          lzma --verbose --compress --threads=$NIX_BUILD_CORES kernel
          install -m0644 ${config.system.build.initrd}/initrd .
          install -m0644 ${config.boot.kernelPackages.kernel}/dtbs/mediatek/mt7981b-openwrt-one.dtb .
          install -m0644 ${./mixos.its} mixos.its
          fdtput -p -t s *.dtb /chosen bootargs "console=ttyS0,115200 debug"
          mkimage --fit mixos.its $out
        ''
    ) { };

    system.build.firmware = pkgs.symlinkJoin {
      name = "openwrt-one-firmware";
      paths = [
        pkgs.openwrtOneAtf
        pkgs.openwrtOneUBoot
      ];
    };

    system.build.ubiImage = pkgs.callPackage (
      {
        runCommand,
        mtdutils,
        formats,
      }:
      runCommand "openwrt-one-ubi-image"
        {
          nativeBuildInputs = [ mtdutils ];

          env = {
            ubinizeConfig = (formats.ini { }).generate "ubinize.ini" (
              listToAttrs (
                imap1
                  (
                    vol_id:
                    { name, value }:
                    {
                      inherit name;
                      value = unionOfDisjoint value {
                        inherit vol_id;
                        vol_name = name;
                      };
                    }
                  )
                  [
                    {
                      name = "ubootenv";
                      value = {
                        mode = "ubi";
                        vol_type = "dynamic";
                        vol_size = "0x${toHexString ubootEnvSize}";
                      };
                    }
                    {
                      name = "ubootenv2";
                      value = {
                        mode = "ubi";
                        vol_type = "dynamic";
                        vol_size = "0x${toHexString ubootEnvSize}";
                      };
                    }
                    {
                      name = "os";
                      value = {
                        mode = "ubi";
                        vol_type = "dynamic";
                        vol_size = "100MiB";
                        image = "os.ubifs";
                        vol_alignment = 1;
                      };
                    }
                    {
                      name = "state";
                      value = {
                        mode = "ubi";
                        vol_type = "dynamic";
                        vol_size = "50MiB";
                        vol_flags = "autoresize";
                        vol_alignment = 1;
                      };
                    }
                  ]
              )
            );
          };
        }
        ''
          mkdir -p $out
          install -Dm0644 ${config.system.build.fitImage} os/mixos.itb
          mkfs.ubifs -m 2048 -e 124KiB -c ${toString (100 * 1024 / 124)} -r os os.ubifs
          ubinize --verbose --output=$out/ubi.img --min-io-size=2048 --peb-size=128KiB $ubinizeConfig
        ''
    ) { };
  };
}
