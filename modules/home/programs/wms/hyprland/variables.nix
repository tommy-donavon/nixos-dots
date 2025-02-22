{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  blurRule = "opacity 0.85 override 0.85 override";
  cfg = config.${namespace}.programs.wms.hyprland;
in
{
  config = mkIf cfg.enable {
    home.sessionVariables = {
      ANKI_WAYLAND = "1";
      GDK_SCALE = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "float,move 0 0,pqiv"
          "float,foot-notes"
        ];

        input = {
          follow_mouse = 0;
          touchpad.natural_scroll = true;
          sensitivity = 1;
        };

        monitor = [
          ", preferred, auto, 1"
        ];

        cursor.no_hardware_cursors = true;

        general = {
          gaps_in = 6;
          gaps_out = 12;
          border_size = 3;
          resize_on_border = true;
        };

        decoration = {
          rounding = 8;
          shadow = {
            range = 60;
          };
          blur = {
            enabled = true;
            xray = false;
            size = 13;
            vibrancy_darkness = 2.0;
            passes = 3;
            vibrancy = 0.1696;
          };
        };

        misc = {
          disable_hyprland_logo = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
        };

        windowrulev2 = [
          "${blurRule},class:com.mitchellh.ghostty"
          "${blurRule},class:zen-alpha"
        ];

        layerrule = [
          "blur, nwg-drawer"
        ];

        xwayland.force_zero_scaling = true;
        dwindle.pseudotile = 0;
      };
    };
  };
}
