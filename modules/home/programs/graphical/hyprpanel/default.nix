{
  lib,
  config,
  namespace,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkIf getExe mkEnableOption;
  cfg = config.${namespace}.programs.graphical.hyprpanel;
in
{
  imports = with inputs; [ hyprpanel.homeManagerModules.hyprpanel ];
  options.${namespace}.programs.graphical.hyprpanel = {
    enable = mkEnableOption "hyprpanel";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cliphist
      hyprpanel
      hyprshot
    ];

    programs.hyprpanel = {
      enable = true;

      hyprland.enable = true;
      overwrite.enable = true;
      theme = "tokyo_night";

      layout = {
        "bar.layouts" = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
              "notifications"
              "systray"
            ];

            middle = [ "media" ];
            right = [
              "volume"
              "clock"
              "network"
              "bluetooth"
              "battery"
            ];
          };
        };
      };

      settings = {
        bar = {
          clock = {
            format = "%I:%M %p";
            icon = "";
          };
          launcher.autoDetectIcon = true;
          media.show_active_only = true;
          notifications.hideCountWhenZero = true;
          workspaces.show_icons = true;
        };

        menus = {
          clock = {
            time = {
              military = true;
              hideSeconds = true;
            };

          };
          dashboard = {
            shortcuts = {
              left = {
                shortcut1 = {
                  command = "zen";
                  icon = "";
                  tooltip = "Zen";
                };
                shortcut2 = {
                  command = "spotify-launcher";
                  icon = "";
                  tooltip = "Spotify";
                };
                shortcut3 = {
                  command = "${getExe pkgs.vesktop}";
                  icon = "";
                  tooltip = "Discord";
                };
                shortcut4 = {
                  command = "${getExe pkgs.wofi} --show drun";
                  icon = "";
                  tooltip = "Search Apps";
                };

              };
            };

            powermenu.avatar.image = "~/dots/assets/icon.jpg";
            directories.enabled = false;
            stats.enable_gpu = true;

          };
        };

        theme.bar.transparent = true;

      };

    };

  };
}
