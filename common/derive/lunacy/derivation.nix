{ stdenv, dpkg, autoPatchelfHook }:
let src = fetchurl { url = "https://lcdn.icons8.com/setup/Lunacy.deb"; };
in
stdenv.mkDerivation {
  name = "lunacy";
  system = "x86_64-linux";

  inherit src;

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
  ];

  # Required at running time
  buildInputs = [
    #glibc
  ];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp -av $out/opt/icons8/lunacy/* $out
    rm -rf $out/opt
    cp -av $out/usr
  '';

  meta = with stdenv.lib; {
    description = "Lunacy";
    homepage = https://icons8.com/lunacy;
    license = licenses.unfree;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
