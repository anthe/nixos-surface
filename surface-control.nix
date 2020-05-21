{stdenv, fetchurl, rustPlatform}:
rustPlatform.buildRustPackage rec {
  name = "surface-control-${version}";
  version = "0.2.5-3";
  src = fetchurl {
    url = "https://github.com/qzed/linux-surface-control/archive/v${version}.tar.gz";
    sha256 = "0llimw0xjf2agr1m3f46c9db87wpxjpdm6300l6sgc28vs03cjkg";
  };
  
  cargoSha256 = "0zq0nqlvzvgzrgr3cx5gbd2x2n3pdzxp1xsy6jhkyk8ap4cr9jp9";
}
