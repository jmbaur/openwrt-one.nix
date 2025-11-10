{
  fetchurl,
  linuxKernel,
  lib,
}:

linuxKernel.manualConfig {
  version = "6.18.0-rc5";
  modDirVersion = "6.18.0-rc5";
  src = fetchurl {
    url = "https://git.kernel.org/torvalds/t/linux-6.18-rc5.tar.gz";
    hash = "sha256-gozH1MrFNBJPzFOxoX4Q+y6INB1xy7MU/R81URkWUqM=";
  };
  configfile = ./kernel.config;
  kernelPatches = lib.mapAttrsToList (name: _: {
    inherit name;
    patch = ./patches/${name};
  }) (builtins.readDir ./patches);
}
