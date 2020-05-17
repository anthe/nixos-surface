{stdenv, fetchurl, glib, pkgconfig, udev, libgudev, meson, libtool, libxml2, ninja, doxygen}:
stdenv.mkDerivation rec {
  name = "libwacom-surface-${version}";
  version = "1.3";

  src = fetchurl {
    url = "https://github.com/linux-surface/libwacom/archive/libwacom-${version}.tar.gz";
    sha256 = "0ibq7w5922mjkbhkxzyvrr9mdz8j3kr0v5l3q8ax600a158l7ra3";
  };

  nativeBuildInputs = [ pkgconfig meson doxygen libtool libxml2 ninja libtool ];

  buildInputs = [ glib udev libgudev ];

}
