{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.${namespace}.programs.graphical.waybar;
  palette = import ./colors.nix;
in
{
  options.${namespace}.programs.graphical.waybar = {
    enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      playerctl
      pavucontrol
      cliphist
      pkgs.${namespace}.wofi-bluetooth
    ];

    /*
        This config is based on the waybar-minimal configuration by ashish-kus
        with light customizations

        source: https://github.com/ashish-kus/waybar-minimal
    */

    programs.waybar = {
      enable = true;
      settings.mainBar = {
        position = "top";
        layer = "top";

        modules-left = [
          "custom/logo"
          "clock"
          "disk"
          "memory"
          "cpu"
          "temperature"
          "hyprland/window"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "tray"
          "custom/clipboard"
          "idle_inhibitor"
          "bluetooth"
          "pulseaudio"
          "network"
          "battery"
        ];

        "custom/logo" = {
          format = "";
          tooltip = false;
          on-click = "powermenu";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "active" = "";
            "default" = "";
          };
          persistent-workspaces = {
            "*" = [
              2
              3
              4
              5
              6
            ];
          };
        };

        idle_inhibitor = {
          format = "<span font='12'>{icon}</span>";
          format-icons = {
            activated = "󰈈";
            deactivated = "󰈉";
          };
        };

        "custom/clipboard" = {
          format = "";
          on-click = "cliphist list | wofi -dmenu | cliphist decode | wl-copy";
          interval = 86400;
        };

        clock = {
          format = "{:%I:%M:%S %p}";
          interval = 1;
          tooltip-format = "\n<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar-weeks-pos = "right";
          today-format = "<span color='#7645AD'><b><u>{}</u></b></span>";
          format-calendar = "<span color='#aeaeae'><b>{}</b></span>";
          format-calendar-weeks = "<span color='#aeaeae'><b>W{:%V}</b></span>";
          format-calendar-weekdays = "<span color='#aeaeae'><b>{}</b></span>";
        };

        bluetooth = {
          format-on = "";
          format-off = "";
          format-disabled = "󰂲";
          format-connected = "󰂴";
          format-connected-battery = "{device_battery_percentage}% 󰂴";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "wofi-bluetooth";
        };

        network = {
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = "";
          tooltip-format = "{ipaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  | {ipaddr}";
          tooltip-format-ethernet = "{ifname} 🖧 | {ipaddr}";
          on-click = "foot -e 'nmtui'";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = " {capacity}% ";
          format-alt = "{icon} {time}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        disk = {
          interval = 30;
          format = "  {percentage_used}%";
          path = "/";
        };

        cpu = {
          interval = 1;
          format = " {usage}%";
          min-length = 6;
          max-length = 6;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };

        memory = {
          format = " {percentage}%";
        };

        "hyprland/window" = {
          format = "( {class} )";
          rewrite = {
            "(.*) - zsh" = "> [$1]";
          };
        };

        temperature = {
          format = " {temperatureC}°C";
          format-critical = " {temperatureC}°C";
          interval = 1;
          critical-threshold = 80;
          on-click = "foot btop";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "󰂰";
          format-muted = "<span font='12'></span>";
          format-icons = {
            headphones = "";
            bluetooth = "󰥰";
            handsfree = "";
            headset = "󱡬";
            phone = "";
            portable = "";
            car = "";
            default = [
              "🕨"
              "🕩"
              "🕪"
            ];
          };
          justify = "center";
          on-click = "amixer sset Master toggle";
          on-click-right = "pavucontrol";
          tooltip-format = "{icon}  {volume}%";
        };

        tray = {
          icon-size = 14;
          spacing = 10;
        };

        upower = {
          show-icon = false;
          hide-if-empty = true;
          tooltip = true;
          tooltip-spacing = 20;
        };

      };

      style = ''
        * {
            border: none;
            font-size: 14px;
            font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF";
            min-height: 25px;
        }

        window#waybar {
          background: transparent;
          margin: 5px;
         }

        #custom-logo {
          padding: 0 10px;
          color: #${palette.teal};
        }

        .modules-right {
          padding-left: 5px;
          border-radius: 15px 0 0 15px;
          margin-top: 2px;
          background: #${palette.surface0};
        }

        .modules-center {
          padding: 0 15px;
          margin-top: 2px;
          border-radius: 15px 15px 15px 15px;
          background: #${palette.surface0};
        }

        .modules-left {
          border-radius: 0 15px 15px 0;
          margin-top: 2px;
          background: #${palette.surface0};
        }

        #battery,
        #custom-clipboard,
        #bluetooth,
        #pulseaudio,
        #network,
        #disk,
        #memory,
        #cpu,
        #temperature,
        #idle_inhibitor,
        #tray,
        #window,
        #workspaces,
        #clock {
          padding: 0 5px;
        }

        #pulseaudio {
          padding-top: 3px;
        }

        #temperature.critical,
        #pulseaudio.muted {
          color: #f38ba8;
          padding-top: 0;
        }

        #clock{
          color: #${palette.peach};
        }

        #battery.charging {
            color: #ffffff;
            background-color: #${palette.green};
        }

        #battery.warning:not(.charging) {
            background-color: #ffbe61;
            color: black;
        }

        #battery.critical:not(.charging) {
            background-color: #f53c3c;
            color: #f38ba8;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }


        @keyframes blink {
            to {
                background-color: #ffffff;
                color: #000000;
            }
        }
      '';
    };
  };
}
