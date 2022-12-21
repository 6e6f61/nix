{ lib, stdenv }:

stdenv.mkDerivation rec {
  pname = "monaco-font";
  version = "1.0";

  src = ./. +  "/monaco.tar.gz";

  installPhase = ''
    install -m444 -Dt $out/share/fonts/truetype ttf/*.ttf
  '';

  meta = with lib; {
    description = "Apple's Monaco monospace font.";
  };
}
