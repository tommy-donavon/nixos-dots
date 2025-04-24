{
  config,
  lib,

  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nest.hardware.bluetooth;
in
{
  options.nest.hardware.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
