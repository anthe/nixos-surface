{stdenv, fetchgit, glib, pkgconfig, udev, libgudev, autoconf, automake, meson, libtool, libxml2, ninja}:
stdenv.mkDerivation rec {
  name = "libwacom-surface-${version}";
  version = "0.32";

  src = fetchgit {
    url = "https://github.com/qzed/libwacom/";
    rev = "e3be71039c05e50d58784b41564c59028f7789fa";
    sha256 = "1rh3s4nj72gg7p2pcfcdx809a57733wpf9xka2ylsam8igs5hn9x";
  };

  nativeBuildInputs = [ pkgconfig autoconf automake meson libtool libxml2 ninja ];

  buildInputs = [ glib udev libgudev ];

}
