{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = {
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;
    programs.xwayland.enable = true;
    nixdots = {
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
