{
  config,
  lib,
  namespace,
  pkgs,
  inputs,
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
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
      zoom-us
      obs-studio
    ];
    nixdots = {
      programs = {
        graphical = {
          wofi = enabled;
          waybar = enabled;
          dunst = enabled;
        };
        wms = {
          hyprland = enabled;
        };
      };
    };
  };
}
