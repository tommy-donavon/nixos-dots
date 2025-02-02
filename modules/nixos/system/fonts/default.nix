{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.fonts;

in
{
  options.${namespace}.system.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.${namespace}.fontcharlist ];
    fonts = {
      packages = with pkgs; [
        jetbrains-mono
        roboto
        openmoji-color
        unifont
        noto-fonts-monochrome-emoji

        (nerdfonts.override {
          fonts = [
            "JetBrainsMono"
            "SpaceMono"
          ];
        })
      ];

      fontconfig = {
        enable = true;
        hinting.autohint = true;
        defaultFonts = {
          emoji = [
            "JetBrainsMono"
            "OpenMoji Color"
            "Noto Color Emoji"
            "Unifont"
            "Noto Monochrome Emoji"
          ];
        };
      };
    };
  };
}
