{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.theme;
in
{
  imports = with inputs; [ stylix.homeManagerModules.stylix ];
  options.${namespace}.theme = {
    enable = mkEnableOption "theme";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = ./wallpaper.png;

      targets.waybar.enable = false;

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
          package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
          name = "FiraCode Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };

  };

}
