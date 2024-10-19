{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.programs.graphical.apps.thunar;
in
{
  options.${namespace}.programs.graphical.apps.thunar = {
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
