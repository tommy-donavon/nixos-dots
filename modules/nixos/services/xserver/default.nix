{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.${namespace}.services.xserver;
in
{
  options.${namespace}.services.xserver = {
    enable = mkEnableOption "xserver";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      desktopManager.gnome.enable = false;
      videoDrivers = [ "nvidia" ];

      desktopManager.xterm.enable = false;
    };
  };
}
