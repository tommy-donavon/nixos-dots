{ config
, lib
, namespace
, ...
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
    nixdots = {
      programs = {
        graphical = {
        wofi = enabled;
        waybar = enabled;
        };
        wms = {
        hyprland = enabled;
        };
      };
    };
  };
}
