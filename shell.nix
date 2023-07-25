{pkgs, ...}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # nix tools
    alejandra

    # erlang stuff
    erlang
    rebar3
    erlang-ls
  ];
}
