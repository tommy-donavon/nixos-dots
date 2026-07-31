{ inputs', self, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [ ./home.nix ];

  nest = {
    aspects = {
      common = enabled;
      development = enabled;
    };
    programs.terminal.editors.nvim.package = inputs'.lunavim.packages.default;
    theme.wallpaper = "angel.png";
  };
}
