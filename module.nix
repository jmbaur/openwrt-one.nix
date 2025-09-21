{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    imap1
    listToAttrs
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

    boot.kernel = pkgs.openwrtOneLinux;

    boot.requiredKernelConfig = [ "FW_LOADER_COMPRESS_XZ" ];
    boot.firmware = [
      (pkgs.runCommand "mediatek-and-wireless-firmware" { } ''
        mkdir -p $out/lib/firmware/mediatek
        cp -r ${pkgs.linux-firmware}/lib/firmware/mediatek/* $out/lib/firmware/mediatek
        cp ${pkgs.wireless-regdb}/lib/firmware/regulatory.db* $out/lib/firmware

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
          nativeBuildInputs = [
            dtc
            ubootTools
            xz
          ];
        }
        ''
          install -m0644 ${config.boot.kernel}/${pkgs.stdenv.hostPlatform.linux-kernel.target} kernel
          lzma --verbose --compress --threads=$NIX_BUILD_CORES kernel
          install -m0644 ${config.system.build.initrd}/initrd .
          install -m0644 ${config.boot.kernel}/dtbs/mediatek/mt7981b-openwrt-one.dtb .
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
          env = {
            ubinizeConfig = (formats.ini { }).generate "ubinize.ini" (
              listToAttrs (
                imap1
                  (
                    vol_id:
                    { name, value }:
                    {
                      inherit name;
                      value = value // {
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
                      name = "state";
                      value = {
                        mode = "ubi";
                        vol_type = "dynamic";
                        vol_size = "100MiB";
                        vol_flags = "autoresize";
                      };
                    }
                  ]
              )
            );
          };

          nativeBuildInputs = [ mtdutils ];
        }
        ''
          mkdir -p $out
          ubinize --verbose --output=$out/ubi.img --min-io-size=2048 --peb-size=128KiB $ubinizeConfig
        ''
    ) { };
  };
}
