{
  pkgs,
  lib,
  config,
  self,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (self.lib.helpers) nixFilesIn;

  cfg = config.nest.programs.wms.hyprland;
in
{
  options.nest.programs.wms.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  imports = nixFilesIn ./.;

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
      # package = null;
      # portalPackage = null;
      systemd = {
        enable = true;
        variables = [ "--all" ];
      };
    };

    nest = {
      programs = {
        graphical = {
          hyprlock.enable = true;
        };
      };
    };
  };
}
