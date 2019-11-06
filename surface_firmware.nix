{stdenv,  unzip, kmod}:
stdenv.mkDerivation rec {
  name = "surface_firmware";

  src = ./linux-surface;

  buildInputs = [ unzip kmod ];

  buildPhase = "";

  installPhase = ''
    mkdir -p "$out/lib/udev/rules.d"
    mkdir "$out/lib/firmware"

    cp -r firmware/* "$out/lib/firmware/"
    cp root/etc/udev/rules.d/* $out/lib/udev/rules.d/
  '';

  # needed for 98-keyboards for reloading nouveau
  # sed -i -e "s|modprobe|${kmod}/bin/modprobe|" $out/lib/udev/rules.d/*
}
