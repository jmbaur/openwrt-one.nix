{
  lib,
  mtk-uartboot,
  python3Packages,
}:

python3Packages.buildPythonPackage {
  pname = "openwrt-one-bootstrap";
  version = "0.1.0";
  pyproject = true;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./pyproject.toml
      ./openwrt_one_bootstrap.py
    ];
  };

  build-system = [ python3Packages.setuptools ];

  dependencies = [
    python3Packages.pexpect
    python3Packages.pyserial
    python3Packages.xmodem
  ];

  makeWrapperArgs = [ "--prefix PATH : ${lib.makeBinPath [ mtk-uartboot ]}" ];

  pythonImportsCheck = [ "openwrt_one_bootstrap" ];

  meta.mainProgram = "openwrt-one-bootstrap";
}
