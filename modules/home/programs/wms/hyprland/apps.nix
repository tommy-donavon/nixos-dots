{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf getExe;
  cfg = config.${namespace}.programs.wms.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "${getExe pkgs.swaybg} -i $NIXOS_CONFIG_DIR/pics/wallpaper.png"
          "${getExe pkgs.foot} --server"
          "${getExe pkgs.wlsunset} -l -23 -L -46"
          "${getExe pkgs.dunst}"
          "${getExe pkgs._1password-gui} --silent"
          "sleep 5s; ${getExe pkgs.waybar}"
          "wl-paste --watch cliphist store"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];
      };
    };
  };
}
