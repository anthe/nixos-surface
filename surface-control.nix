{stdenv, fetchurl, rustPlatform}:
rustPlatform.buildRustPackage rec {
  name = "surface-control-${version}";
  version = "0.2.5";
  src = fetchurl {
    url = "https://github.com/qzed/linux-surface-control/archive/v${version}.tar.gz";
    sha256 = "0rwfbl8kxcd5zrn3dcil0s80cbqxmx1mnr934f51fnik6kf0niak";
  };

 cargoSha256 = "16w34wpgs2lv5mm5ph3h7qrij065asikqm32h17anm4i8rzjyvmw";
}
