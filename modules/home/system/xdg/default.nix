{ lib, config, pkgs, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.xdg;

in
{
  options.${namespace}.system.xdg = {
    enable = mkEnableOption "xdg";
  };
  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      cacheHome = config.home.homeDirectory + "/.local/cache";
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_BIN_HOME = config.home.homeDirectory + "/bin";
        };
      };
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
        config.common.default = "*";
      };
    };
  };
}
