{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.hardware.pipewire;
in
{
  options.${namespace}.hardware.pipewire = {
    enable = mkEnableOption "pipewire";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
