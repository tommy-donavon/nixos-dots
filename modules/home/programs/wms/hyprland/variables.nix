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
          sensitivity = 1;
        };

        monitor = [
          "desc:Chimei Innolux Corporation 0x150C,preferred,auto,1"
          "desc:HP Inc. HP 24ec 3CM0270DJS, preferred, auto, 1"
        ];

        cursor.no_hardware_cursors = true;

        general = {
          gaps_in = 6;
          gaps_out = 12;
          border_size = 4;
          resize_on_border = true;
        };

        decoration = {
          rounding = 8;
          shadow = {
            range = 60;
          };
        };

        xwayland.force_zero_scaling = true;
        dwindle.pseudotile = 0;
      };
    };
  };
}
