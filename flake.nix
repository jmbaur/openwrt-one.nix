{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mixos.url = "github:jmbaur/mixos";
  };

  outputs = inputs: {
    mixosModules.default = {
      imports = [ ./module.nix ];
      nixpkgs.overlays = [ inputs.self.overlays.default ];
    };

    overlays.default = inputs.nixpkgs.lib.composeManyExtensions [
      (
        final: prev:
        prev.lib.packagesFromDirectoryRecursive {
          inherit (final) callPackage;
          directory = ./pkgs;
        }
      )
      (final: _: {
        openwrtOneAtfRam = final.openwrtOneAtf.override { bootDevice = "ram"; };
      })
    ];

    legacyPackages = inputs.nixpkgs.lib.genAttrs [ "x86_64-linux" ] (
      system:
      import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.self.overlays.default ];
      }
    );

    mixosConfigurations.one = inputs.mixos.lib.mixosSystem {
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
            nixpkgs.nixpkgs = inputs.nixpkgs;
            nixpkgs.buildPlatform = "x86_64-linux";
            hardware.openwrt-one.enable = true;

            # TODO(jared): integrate this better into mixos (e.g. kernelPackages?)
            etc."mdio-netlink".source = pkgs.mdio-netlink.override {
              inherit (config.boot) kernel;
            };

            bin = [
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

            init.hostapd = {
              action = "respawn";
              process = "${lib.getExe' pkgs.hostapd "hostapd"} ${./hostapd.conf}";
            };
          }
        )
      ];
    };
  };
}
