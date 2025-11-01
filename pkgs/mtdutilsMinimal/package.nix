{ mtdutils, libuuid }:

mtdutils.overrideAttrs {
  pname = "mtdutils-minimal";
  buildInputs = [ libuuid ];
  postPatch = "";
}
