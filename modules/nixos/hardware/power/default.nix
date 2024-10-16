{ config, lib, namespace, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.hardware.power;
in
{
  options.${namespace}.hardware.power = {
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
