{
  fetchurl,
  linuxKernel,
  lib,
}:

linuxKernel.manualConfig {
  version = "6.18.0-rc3";
  modDirVersion = "6.18.0-rc3";
  src = fetchurl {
    url = "https://git.kernel.org/torvalds/t/linux-6.18-rc3.tar.gz";
    hash = "sha256-t05Yk34ZYonFkjjYQgjKZo1gyEl+UOAXdc5pb4ZKFww=";
  };
  configfile = ./kernel.config;
  kernelPatches = lib.mapAttrsToList (name: _: {
    inherit name;
    patch = ./patches/${name};
  }) (builtins.readDir ./patches);
}
