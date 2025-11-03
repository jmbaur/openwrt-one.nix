{
  fetchurl,
  linuxKernel,
  lib,
}:

linuxKernel.manualConfig {
  version = "6.18.0-rc4";
  modDirVersion = "6.18.0-rc4";
  src = fetchurl {
    url = "https://git.kernel.org/torvalds/t/linux-6.18-rc4.tar.gz";
    hash = "sha256-DtR8sFwexWyzondmRXXaSbHZ7W/QK2dMwp/zfg+TsKE=";
  };
  configfile = ./kernel.config;
  kernelPatches = lib.mapAttrsToList (name: _: {
    inherit name;
    patch = ./patches/${name};
  }) (builtins.readDir ./patches);
}
