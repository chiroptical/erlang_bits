{
  pkgs,
  system,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "elp";

  src =
    if builtins.elem system ["aarch64-darwin" "x86_64-darwin"]
    then
      pkgs.fetchzip {
        url = "https://github.com/WhatsApp/erlang-language-platform/releases/download/2023-09-07_1/elp-macos-otp-25.3.tar.gz";
        sha256 = "sha256-JVnd867lYc7mQqfYYiCOEI+nFPiUXrpEf0awRFVysW0=";
      }
    else # x86_64-linux
      pkgs.fetchzip {
        url = "https://github.com/WhatsApp/erlang-language-platform/releases/download/2023-09-07_1/elp-linux-otp-26.tar.gz";
        sha256 = "sha256-yiSyP1N17Dkh0tDnGumE6RyIXBtNGhikF8G1kqOJf/Q";
      };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/elp $out/bin
  '';
}
