{ config
, lib
, namespace
, ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.hardware.fingerprint;
in
{
  options.${namespace}.hardware.fingerprint = {
    enable = mkEnableOption "fingerprint";
  };

  config = mkIf cfg.enable { services.fprintd.enable = true; };
}
