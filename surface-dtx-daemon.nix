{stdenv, fetchurl, rustPlatform, pkgconfig, dbus}:
rustPlatform.buildRustPackage rec {
  name = "surface-dtx-daemon-${version}";
  version = "0.1.4";
  src = fetchurl {
    url = "https://github.com/linux-surface/surface-dtx-daemon/archive/v${version}.tar.gz";
    sha256 = "1h4k8js6qwdbj4y2xqiayc45jiym8zmh1l6wl85nq3i2zls3xb11";
  };

  buildInputs = [ pkgconfig dbus ];

  cargoSha256 = "1jr5l3rbfpgii1y4z29rx1vwqbsf4spqyddjpiyh4w9q7y82s7pp";
}
