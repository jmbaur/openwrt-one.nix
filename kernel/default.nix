{
  lib,
  linuxKernel,
  kernelPatches ? [ ],
}:

linuxKernel.manualConfig {
  inherit (linuxKernel.kernels.linux_7_2) src version;
  configfile = ./kernel.config;
  kernelPatches =
    kernelPatches
    ++ (lib.mapAttrsToList (lib.flip (
      lib.const (name: {
        inherit name;
        patch = ./patches/${name};
      })
    )) (builtins.readDir ./patches));
}
