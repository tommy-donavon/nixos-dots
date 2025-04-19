{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.nest.programs.wms.hyprland;
in
{
  options.nest.programs.wms.hyprland = {
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
