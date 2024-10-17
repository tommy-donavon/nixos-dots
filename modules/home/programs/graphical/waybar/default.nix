{ lib, config,namespace, pkgs, ... }:
with lib;
let
  cfg = config.${namespace}.programs.graphical.waybar;
  palette = import ./colors.nix;
in
{
  options.${namespace}.programs.graphical.waybar = { enable = mkEnableOption "waybar"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      playerctl
      pavucontrol
    ];

    programs.waybar = {
      enable = true;
      settings.mainBar = {
        position = "top";
        layer = "top";
        height = 35;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;

        modules-left = [
          "custom/power"
          "hyprland/workspaces"
          "clock#time"
          "clock#date"
          "battery"
        ];

        modules-center = [
          "custom/playerctl#backward"
          "custom/playerlabel"
          "custom/playerctl#forward"
        ];

        modules-right = [
          "tray"
          "temperature"
          # "cpu"
          # "memory"
          "network"
          "pulseaudio"
        ];

        "clock#time" = {
          "format" = "<span color=\"#7aa2f7\"> </span>{:%H:%M:%S}";
          "interval" = 1;
        };
        "clock#date" = {
          "format" = "<span color=\"#7aa2f7\"> </span>{:%d/%m/%Y}";
          "tooltip-format" = "<tt>{calendar}</tt>";
          "interval" = 360;
          "calendar" = {
            "mode" = "month";
            "mode-mon-col" = 4;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#c0caf5'><b>{}</b></span>";
              "days" = "<span color='#c0caf5'><b>{}</b></span>";
              "weeks" = "<span color='#7dcfff'><b>W{}</b></span>";
              "weekdays" = "<span color='#ff9e64'><b>{}</b></span>";
              "today" = "<span color='#f7768e'><b><u>{}</u></b></span>";
            };
          };
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "{ifname} ";
          format-disconnected = "";
          max-length = 50;
          on-click = "foot -e 'nmtui'";
          tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
        };

        tray = {
          icon-size = 15;
          spacing = 10;
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
          format-icons = [ "" "" "" "" "" ];
        };

        # cpu = {
        #   format = "<span>color=\"#7aa2f7\"> </span>{usage}%";
        #   interval = 4;
        # };

        # memory = {
        #   format = "<span color=\"#7aa2f7\">🧠 </span>{used}GiB";
        #   internal = 4;
        # };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
          critical-threshold = 80;
          format = "<span color=\"#7aa2f7\">🌡 </span>{temperatureC}°C";
          format-critical = "<span color=\"#f7768e\"> </span>{temperatureC}°C";
          interval = 4;
        };

        pulseaudio = {
          format = "{volume}% {icon} ";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = " {icon}  {format_source}";
          format-muted = "0% {icon} ";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "custom/power" = {
          "format" = "";
          "on-click" = "powermenu";
        };

        "custom/playerctl#play" = {
          format = "{icon}";
          return-type = "json";
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl play-pause";
          on-scroll-up = "playerctl volume .05+";
          on-scroll-down = "playerctl volume .05-";
          format-icons = {
            Playing = "<span>󰏥 </span>";
            Paused = "<span> </span>";
            Stopped = "<span> </span>";
          };
        };

        "custom/playerctl#forward" = {
          format = " 󰙡 ";
          on-click = "playerctl next";
          on-scroll-up = "playerctl volume .05+";
          on-scroll-down = "playerctl volume .05-";
        };

        "custom/playerctl#backward" = {
          format = "󰙣 ";
          on-click = "playerctl previous";
          on-scroll-up = "playerctl volume .05+";
          on-scroll-down = "playerctl volume .05-";
        };

        "custom/playerlabel" = {
          format = "<span>{}</span>";
          return-type = "json";
          max-length = 45;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl play-pause";
        };

      };
      style = ''        
       * {
       	font-family:
           SpaceMono Nerd Font,
           feather;
       	font-weight: 600;
       	font-size: 12px;
       	color: #${palette.text};
       }
      
       window#waybar {
       	background: none;
       }
      
       tooltip {
       	background: #${palette.mauve};
       	border-radius: 5%;
       }
       
       #workspaces button {
       	padding: 2px;
       }

        #workspaces button.occupied {
          transition: none;
          color: #${palette.subtext1};
          background: transparent;
      }
        #workspaces button.focused {
          color: #${palette.subtext1};
          border-top: 2px solid #${palette.mantle};
          border-bottom: 2px solid #${palette.mantle};
        }

        #workspaces button.active {
          border-bottom: 2px solid #${palette.sapphire};
        }

        #workspaces button.urgent {
          color: #f7768e;
        }

        #workspaces button:hover {
          background: #${palette.surface1};
          color: #${palette.subtext1};
        }

        #workspaces,
        #clock,
        #window,
        #temperature,
        #cpu,
        #memory,
        #pulseaudio,
        #network,
        #tray,
        #custom-power,
        #battery {
          background: #${palette.base};
          padding: 0 10px;
          border: 0;
        }

        #custom-power {
          color: #${palette.teal};
        }

        #tray {
          border-radius: 12px;
          margin-right: 4px;
        }
        
        #window {
          border-radius: 12px;
        }

        #temperature {
          border-radius: 12px 0 0 12px;
        }
        
        /* close left side of bar */
        #battery {
          border-radius: 0 12px 12px 0;
        }


      '';
    };
  };
}
