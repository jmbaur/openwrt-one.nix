{
  autoreconfHook,
  fetchFromGitHub,
  libmnl,
  pkg-config,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "mdio-tools";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "wkz";
    repo = finalAttrs.pname;
    tag = finalAttrs.version;
    hash = "sha256-NomChJrYwMDPXNw5r2p11kGfYUvJBHCdLXy1SA8kOaM=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];
  buildInputs = [ libmnl ];

  postPatch = ''
    substituteInPlace configure.ac \
      --replace-fail "git describe --always --dirty --tags" "echo ${finalAttrs.version}"
  '';
})
