{pkgs, ...}: let
  elp = pkgs.callPackage ./nix/elp.nix {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      # nix tools
      alejandra

      # erlang stuff
      erlang
      rebar3
      erlang-ls
      elp
    ];
  }
