{ self, ... }:
let
  inherit (self.lib.helpers) mkTemplate;
in
{
  flake.templates = {
    elixir = mkTemplate {
      name = "Elixir Development Shell";
      description = "A development shell for Elixir projects with Hex and Mix2Nix.";
      path = ./elixir;
      buildTools = [
        "elixir"
        "hex"
        "mix2nix"
      ];
    };
  };

}
