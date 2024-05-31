{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.packages.stylix;
in
{
  options.modules.packages.stylix = {
    enable = mkEnableOption "stylix";
  };

  config = mkIf cfg.enable {
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      stylix.image = ../../pics/wallpaper.png;
  };
}
