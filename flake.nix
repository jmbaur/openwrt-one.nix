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
      (final: prev: {
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
          { pkgs, ... }:
          {
            nixpkgs.nixpkgs = inputs.nixpkgs;
            nixpkgs.buildPlatform = "x86_64-linux";
            hardware.openwrt-one.enable = true;

            bin = [
              pkgs.hostapd
              pkgs.iw
              pkgs.kexec-tools
              pkgs.mtdutilsMinimal
              pkgs.nftables
              pkgs.traceroute
            ];

            init.shell = {
              tty = "ttyS0";
              action = "askfirst";
              process = "/bin/sh";
            };
          }
        )
      ];
    };
  };
}
