{
  stdenv,
  linux,
  kernel ? linux,
  mdio-tools,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "mdio-netlink";
  version = mdio-tools.version;

  src = mdio-tools.src;
  sourceRoot = "source/kernel";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  hardeningDisable = [ "pic" ];

  makeFlags = kernel.commonMakeFlags ++ [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=${placeholder "out"}"
  ];
})
