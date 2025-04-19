{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.system.xdg;

in
{
  options.nest.system.xdg = {
    enable = mkEnableOption "xdg";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdg = {
      #enable = true;
      #cacheHome = config.home.homeDirectory + "/.local/cache";
      # userDirs = {
      #   enable = true;
      #   createDirectories = true;
      #   extraConfig = {
      #     #    XDG_BIN_HOME = config.home.homeDirectory + "/bin";
      #   };
      # };
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
        config.common.default = "*";
        # config = {
        #   common.default = [ "gtk" ];
        #   hyprland.default = [
        #     "gtk"
        #     "hyprland"
        #   ];
        # };
      };
    };
  };
}
