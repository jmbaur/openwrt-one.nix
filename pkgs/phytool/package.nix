{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation (finalAttrs: {
  pname = "phytool";
  version = builtins.substring 0 7 finalAttrs.src.rev;

  src = fetchFromGitHub {
    owner = "wkz";
    repo = "phytool";
    rev = "bcf23b0261aa9f352ee4b944e30e3482158640a4";
    hash = "sha256-8e2DVjG/2CtJ/+FLzMa1VKajJZfFqjD54XQAMY+0q3U=";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  preInstall = ''
    mkdir -p $out/bin
  '';
})
