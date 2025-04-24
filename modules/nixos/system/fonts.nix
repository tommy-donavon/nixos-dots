{
  pkgs,
  lib,
  config,

  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.system.fonts;

in
{
  options.nest.system.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
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
        useEmbeddedBitmaps = true;
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
