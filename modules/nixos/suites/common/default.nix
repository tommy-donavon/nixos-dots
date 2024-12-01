{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = {
    enable = mkBoolOpt false "Whether or not to enable common configuration";
  };

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    nixdots = {
      security = {
        doas = enabled;
      };

      hardware = {
        audio = enabled;
        bluetooth = enabled;
        fingerprint = enabled;
        logitech = enabled;
        nvidia = enabled;
        graphics = enabled;
        power = enabled;
      };

      system = {
        boot = enabled;
        env = enabled;
        fonts = enabled;
        locale = enabled;
        networking = enabled;
        xdg = enabled;
      };
    };
  };
}
