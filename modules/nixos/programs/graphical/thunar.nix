{
  config,
  lib,
  pkgs,

  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.programs.graphical.apps.thunar;
in
{
  options.nest.programs.graphical.apps.thunar = {
    enable = mkEnableOption "thunar";
  };

  config = mkIf cfg.enable {
    programs.xfconf.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
