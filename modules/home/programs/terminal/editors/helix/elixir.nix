{ pkgs, ... }:
{
  home.packages = with pkgs; [
    beam.packages.erlang.elixir-ls
  ];

  programs.helix.languages = {
    language = [
      {
        name = "elixir";
        indent = {
          tab-width = 2;
          unit = "\t";
        };

        auto-format = true;
        comment-token = "#";
        file-types = [ "ex" "exs" ];
        roots = [ "mix.exs" ];
      }
    ];

    language-server.elixir-ls = {
      command = "${pkgs.elixir-ls}/bin/elixir-ls";
    };
  };
}
