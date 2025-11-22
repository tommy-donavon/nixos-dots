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

  cfg = config.nest.services.power;
in
{
  options.nest.services.power = {
    enable = mkEnableOption "power";
  };

  config = mkIf cfg.enable {
    services.power-profiles-daemon = {
      enable = true;
    };
  };
}
