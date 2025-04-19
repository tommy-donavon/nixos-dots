{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.hardware.fingerprint;
in
{
  options.nest.hardware.fingerprint = {
    enable = mkEnableOption "fingerprint";
  };

  config = mkIf cfg.enable { services.fprintd.enable = true; };
}
