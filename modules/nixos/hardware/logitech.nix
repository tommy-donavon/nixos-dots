{
  config,
  lib,

  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nest.hardware.logitech;
in
{
  options.nest.hardware.logitech = {
    enable = mkEnableOption "logitech";
  };

  config = mkIf cfg.enable {
    hardware.logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
  };
}
