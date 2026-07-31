{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (self.lib.module) mkBoolOpt;

  cfg = config.nest.aspects.gnome;
in
{
  options.nest.aspects.gnome = {
    enable = mkBoolOpt false "Enable GNOME desktop. Mutually exclusive with nest.aspects.desktop (Hyprland).";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      dconf.enable = true;
      xwayland.enable = true;
    };

    services = {
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "*";
    };

    environment.gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-tour
      gnome-music
      gnome-contacts
    ];
  };
}
