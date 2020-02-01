{stdenv, fetchgit, glib, pkgconfig, udev, libgudev, meson, libtool, libxml2, ninja, doxygen}:
stdenv.mkDerivation rec {
  name = "libwacom-surface-${version}";
  version = "0.32";

  src = fetchgit {
    url = "https://github.com/linux-surface/libwacom";
    rev = "3eae724987ea38c0613d4bdfdbeafccf518448d6";
    sha256 = "065k98rj7x7cxgn7rfjj4ds29nqj97hrqqwfm5d65kbzpr776j1i";

  };

  nativeBuildInputs = [ pkgconfig meson doxygen libtool libxml2 ninja libtool ];

  buildInputs = [ glib udev libgudev ];

}
