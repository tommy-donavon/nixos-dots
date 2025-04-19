{
  config,
  lib,
  pkgs,
  inputs,
  self,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (self.lib.module) mkOpt;

  cfg = config.nest.theme;
in
{
  imports = with inputs; [ stylix.homeManagerModules.stylix ];
  options.nest.theme = {
    enable = mkEnableOption "theme";
    theme =
      mkOpt lib.types.str "everforest"
        "name of theme to apply to system. must be from base16 schemes repo";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.theme}.yaml";

      targets.hyprlock.enable = false;

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
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        };

        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji;
        };

      };
    };

  };

}
