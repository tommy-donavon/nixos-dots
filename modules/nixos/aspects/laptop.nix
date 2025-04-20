{
  config,
  lib,
  self,
  ...
}:
let
  inherit (self.lib.module) mkBoolOpt enabled;

  cfg = config.nest.aspects.laptop;
in
{
  options.nest.aspects.laptop = {
    enable = mkBoolOpt false "Whether or not to enable common configuration";
  };

  config = lib.mkIf cfg.enable {
    nest = {
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
        pipewire = enabled;
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
