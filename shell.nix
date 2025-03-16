{ pkgs, ... }:
let
  elp = pkgs.callPackage ./nix/elp.nix { };
in
pkgs.mkShell {
  buildInputs =
    (with pkgs; [
      elp
      gleam
      nixfmt-rfc-style
    ])
    ++ (with pkgs.beam.packages.erlang_27; [
      erlang
      elixir
    ]);
}
