{ lib, config, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.networking;

in
{
  options.${namespace}.system.networking = {
    enable = mkEnableOption "networking";
  };

  config = mkIf cfg.enable {
    networking = {
      wireless.iwd.enable = true;
      networkmanager.enable = true;
    };
  };
}
