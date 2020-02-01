{stdenv,  unzip, kmod}:
stdenv.mkDerivation rec {
  name = "surface_firmware";

  src = ./linux-surface;

  buildPhase = "";

  installPhase = ''
    mkdir -p "$out/lib/firmware"
    cp -r firmware/* "$out/lib/firmware/"
  '';
}
