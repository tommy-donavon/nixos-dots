{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.nest.services.udisk;
in
{
  options.nest.services.udisk = {
    enable = mkEnableOption "udisk";
  };

  config = mkIf cfg.enable {
    services.udisks2.enable = true;
  };
}
