{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.nest.services.xserver;
in
{
  options.nest.services.xserver = {
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
