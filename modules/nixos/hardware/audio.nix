{
  config,
  lib,

  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.hardware.audio;
in
{
  options.nest.hardware.audio = {
    enable = mkEnableOption "audio";
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
  };
}
