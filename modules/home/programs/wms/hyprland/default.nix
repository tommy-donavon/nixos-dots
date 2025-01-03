{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:

with lib;
let
  cfg = config.${namespace}.programs.wms.hyprland;
in
{
  options.${namespace}.programs.wms.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      hyprlock
      swaybg
      wl-clipboard
      wlsunset
      xdg-utils
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = [ "--all" ];
      xwayland.enable = true;
    };

    nixdots = {
      programs = {
        graphical = {
          hyprlock.enable = true;
        };
      };
    };
  };
}
