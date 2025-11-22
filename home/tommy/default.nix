{
  inputs',
  self,
  ...
}:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [
    ./gtk.nix
    ./home.nix
  ];

  nest = {
    aspects = {
      common = enabled;
      development = enabled;
    };
    programs = {
      graphical = {
        rofi = enabled;
        caelestia = enabled;
      };
      terminal.editors.nvim.package = inputs'.lunavim.packages.default;
      wms.hyprland = enabled;

    };
    theme.wallpaper = "angel.png";
  };
}
