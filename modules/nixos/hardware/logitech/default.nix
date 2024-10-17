{ config
, lib
, namespace
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.hardware.logitech;
in
{
  options.${namespace}.hardware.logitech = {
    enable = mkEnableOption "logitech";
  };

  config = mkIf cfg.enable {
    hardware.logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
  };
}
