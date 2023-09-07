{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "elp";

  src = pkgs.fetchurl {
    url = "https://github.com/WhatsApp/erlang-language-platform/releases/download/2023-09-07_1/elp-linux-otp-26.tar.gz";
    sha256 = "sha256-yiSyP1N17Dkh0tDnGumE6RyIXBtNGhikF8G1kqOJf/Q";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    tar xvf $src -C $out/bin
  '';
}
