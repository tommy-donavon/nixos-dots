{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nest.hardware.power;
in
{
  options.nest.hardware.power = {
    enable = mkEnableOption "power";
  };

  config = mkIf cfg.enable {
    services.upower = {
      enable = true;
      percentageAction = 5;
      percentageCritical = 10;
      percentageLow = 25;
    };
  };
}
