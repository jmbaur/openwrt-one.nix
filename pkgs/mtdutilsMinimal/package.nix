{ mtdutils, libuuid }:

mtdutils.overrideAttrs (old: {
  pname = "mtdutils-minimal";
  buildInputs = [ libuuid ];
  postPatch = "";
})
