{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
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
        };

        monitor = [
          "desc:Chimei Innolux Corporation 0x150C,preferred,auto,1"
          "desc:HP Inc. HP 24ec 3CM0270DJS, preferred, auto, 1"
        ];

        cursor.no_hardware_cursors = true;

        general = {
          sensitivity = 1;
          gaps_in = 6;
          gaps_out = 12;
          border_size = 4;
          #"col.active_border" = "0xffb072d1";
          #"col.inactive_border" = "0xff292a37";
        };

        decoration = {
          rounding = 8;
          drop_shadow = 0;
          shadow_range = 60;
          #"col.shadow" = "0x66000000";
        };

        xwayland.force_zero_scaling = true;
        dwindle.pseudotile = 0;
      };
    };
  };
}
