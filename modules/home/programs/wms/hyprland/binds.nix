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
        bind =
          [

            "SUPER,D,exec,${getExe pkgs.wofi} --show run --style=$HOME/.config/wofi.css --term=footclient"
            "SUPER,Return,exec,ghostty"
            "SUPER_SHIFT,Q,killactive,"
            "SUPER,V,togglefloating,"
            "SUPER,F,fullscreen,0"

            "SUPER,h,movefocus,l"
            "SUPER,l,movefocus,r"
            "SUPER,k,movefocus,u"
            "SUPER,j,movefocus,d"

            "SUPER_SHIFT,h,movewindow,l"
            "SUPER_SHIFT,l,movewindow,r"
            "SUPER_SHIFT,k,movewindow,u"
            "SUPER_SHIFT,j,movewindow,d"

            # screenshot monitor
            "CTRL SHIFT,M,exec,${getExe pkgs.hyprshot} -m output -o $HOME/Pictures/Screenshots"
            # screenshot region
            "CTRL SHIFT,R,exec,${getExe pkgs.hyprshot} -m region -o $HOME/Pictures/Screenshots"

            ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
            ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
            ",XF86AudioRaiseVolume,exec,pamixer -i 5"
            ",XF86AudioLowerVolume,exec,pamixer -d 5"
          ]
          ++ builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "SUPER, ${ws}, workspace, ${toString (x + 1)}"
                "SUPER SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            ) 10
          );

        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
        bindle = [
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86MonBrightnessDown, exec, bri --down"
          ", XF86MonBrightnessUp, exec, bri --up"
          ", XF86Search, exec, launchpad"
        ];
        bindm = [ "SUPER,mouse:272,movewindow" ];
      };
    };
  };
}
