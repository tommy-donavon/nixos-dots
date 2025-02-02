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
          "${getExe pkgs.foot} --server"
          "${getExe pkgs.wlsunset} -l -23 -L -46"
          "${getExe pkgs._1password-gui} --silent"
          "wl-paste --watch cliphist store"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];
      };
    };
  };
}
