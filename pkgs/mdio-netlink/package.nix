{
  stdenv,
  linux,
  kernel ? linux,
  mdio-tools,
}:

stdenv.mkDerivation {
  pname = "mdio-netlink";
  inherit (mdio-tools) version;

  inherit (mdio-tools) src;
  sourceRoot = "source/kernel";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernel.commonMakeFlags ++ [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=${placeholder "out"}"
  ];
}
