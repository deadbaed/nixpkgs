{
  lib,
  stdenv,
  fetchFromGitHub,
  testVersion,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "bootterm";
  version = "0.5";

  src = fetchFromGitHub {
    owner = "wtarreau";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-AYpO2Xcd51B2qVUWoyI190BV0pIdA3HfuQJPzJ4yT/U=";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  passthru.tests = {
    version = testVersion {
      package = finalAttrs.finalPackage;
      command = "${finalAttrs.meta.mainProgram} -V";
      version = finalAttrs.version;
    };
  };

  meta = with lib; {
    description = "Simple, reliable and powerful terminal to ease connection to serial ports";
    longDescription = ''
      BootTerm is a simple, reliable and powerful terminal designed to
      ease connection to ephemeral serial ports as found on various SBCs,
      and typically USB-based ones.
    '';
    homepage = "https://github.com/wtarreau/bootterm";
    license = licenses.mit;
    mainProgram = "bt";
    maintainers = with maintainers; [ deadbaed ];
    platforms = platforms.linux ++ platforms.darwin ++ platforms.freebsd;
  };
})
