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
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
      image = ./wallpaper.png;

      targets.waybar.enable = false;
      targets.hyprlock.enable = false;

      fonts = {
        sizes = {
          terminal = 16;
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
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
          name = "JetBrainsMono Nerd Font";
        };
      };
    };

  };

}
