{
  lib,
  config,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.system.networking;

in
{
  options.nest.system.networking = {
    enable = mkEnableOption "networking";
  };

  config = mkIf cfg.enable {
    networking = {
      wireless.iwd.enable = true;
      networkmanager = {
        enable = true;
        wifi.powersave = false;
      };
    };
  };
}
