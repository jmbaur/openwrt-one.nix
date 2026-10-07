{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    mixos.url = "github:jmbaur/mixos";
  };

  outputs = inputs: {
    mixosModules.default.imports = [ ./module.nix ];

    overlays.default = inputs.nixpkgs.lib.composeManyExtensions [
      (
        final: prev:
        prev.lib.packagesFromDirectoryRecursive {
          inherit (final) callPackage;
          directory = ./pkgs;
        }
      )
      (final: _: {
        openwrtOneAtfRam = final.openwrtOneAtf.override {
          bootDevice = "ram";
          openwrtOneUBoot = final.openwrtOneUBoot.override { ramBoot = true; };
        };
      })
    ];

    legacyPackages = inputs.nixpkgs.lib.genAttrs [ "x86_64-linux" ] (
      system:
      import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.self.overlays.default ];
      }
    );

    devShells.x86_64-linux.default =
      let
        pkgs = inputs.self.legacyPackages.x86_64-linux;
      in
      pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (ps: [
            ps.pexpect
            ps.pyserial
            ps.xmodem
          ]))
          pkgs.mtk-uartboot
        ];
      };

    mixosConfigurations.example = inputs.mixos.lib.mixosSystem {
      modules = [
        inputs.self.mixosModules.default
        (
          {
            config,
            lib,
            pkgs,
            ...
          }:
          {
            nixpkgs.pkgs = import inputs.nixpkgs {
              localSystem = "x86_64-linux";
              crossSystem = "aarch64-linux";
              overlays = [ inputs.self.overlays.default ];
            };

            hardware.openwrt-one.enable = true;

            boot.extraModulePackages = [ config.boot.kernelPackages.mdio-netlink ];

            packages = [
              pkgs.hostapd
              pkgs.iw
              pkgs.kexec-tools
              pkgs.libgpiod
              pkgs.mdio-tools
              pkgs.mtdutilsMinimal
              pkgs.net-tools
              pkgs.nftables
              pkgs.phytool
              pkgs.traceroute
            ];

            init.shell = {
              tty = "ttyS0";
              action = "askfirst";
              process = "/bin/sh";
            };

            users.root = {
              uid = 0;
              gid = 0;
            };

            groups.root = {
              id = 0;
            };

            services.hostapd.run = pkgs.writeScript "hostapd-run" ''
              #!/bin/sh
              exec ${lib.getExe' pkgs.hostapd "hostapd"} ${./hostapd-2ghz.conf} ${./hostapd-5ghz.conf}
            '';
          }
        )
      ];
    };
  };
}
