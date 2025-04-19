{
  config,
  lib,
  self,
  ...
}:
let
  inherit (self.lib.module) mkBoolOpt enabled;

  cfg = config.nest.suites.desktop;
in
{
  options.nest.suites.desktop = {
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      dconf.enable = true;
      xwayland.enable = true;
    };
    nest = {
      programs = {
        graphical = {
          apps = {
            _1password = {
              enable = true;
              enableSshSocket = true;
            };
            thunar = enabled;
            steam = enabled;
          };
        };
      };
    };
  };
}
