{
  config,
  lib,
  pkgs,
  inputs,
  self,
  ...
}:
let
  inherit (self.lib.module) mkOpt;

  cfg = config.nest.theme;
in
{
  imports = with inputs; [ stylix.homeModules.stylix ];
  options.nest.theme = {
    theme =
      mkOpt lib.types.str "rose-pine-moon"
        "name of theme to apply to system. must be from base16 schemes repo";
    wallpaper =
      mkOpt lib.types.str "pixel_desk.png"
        "name of wallpaper from https://github.com/tommy-donavon/wallpapers";
  };

  config = {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.theme}.yaml";

      targets = {
        hyprlock.enable = false;
        starship.enable = false;
        firefox.profileNames = [ config.home.username ];
      };

      image = "${inputs.wallpapers}/${cfg.wallpaper}";

      cursor = {
        name = "capitaine-cursors-white";
        package = pkgs.capitaine-cursors;
        size = 14;
      };
      fonts = {
        sizes = {
          terminal = 12;
          applications = 12;
          popups = 12;
        };

        serif = {
          name = "Source Serif";
          package = pkgs.source-serif;
        };

        sansSerif = {
          name = "Noto Sans";
          package = pkgs.noto-fonts;
        };

        monospace = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };

        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji;
        };

      };
    };

  };

}
