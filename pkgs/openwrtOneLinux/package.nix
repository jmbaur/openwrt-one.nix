{ lib, linuxKernel }:

linuxKernel.manualConfig {
  inherit (linuxKernel.kernels.linux_6_18) src version;
  configfile = ./kernel.config;
  kernelPatches = lib.mapAttrsToList (name: _: {
    inherit name;
    patch = ./patches/${name};
  }) (builtins.readDir ./patches);
}
