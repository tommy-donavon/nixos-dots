{ config
, lib
, namespace
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.hardware.nvidia;
in
{
  options.${namespace}.hardware.nvidia = {
    enable = mkEnableOption "nvidia";
  };

  config = mkIf cfg.enable {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;

      nvidiaSettings = true;
    };
  };
}
