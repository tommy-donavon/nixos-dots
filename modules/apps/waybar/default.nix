{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.apps.waybar;

  custom = {
    font = "JetBrains Mono";
    fontsize = "12";
    primary_accent = "cba6f7";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "11111B";
    opacity = ".85";
    cursor = "Numix-Cursor";
    palette = import ./colors.nix;
  };
in
{
  options.modules.apps.waybar = { enable = mkEnableOption "waybar"; };

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
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "battery"
          "network"
          "pulseaudio"
        ];

        # clock = {
        #   format = "{:%a, %d %b}";
        #   tooltip = "true";
        #   tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        # };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "{ifname} ";
          format-disconnected = "";
          max-length = 50;
          on-click = "foot -e 'nmtui'";
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

        pulseaudio = {
          format = "{volume}% {icon} ";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
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
          "format" = " ";
          # "on-click" = "swaynag -t warning -m 'Power Menu Options' -b 'Logout' 'swaymsg exit' -b 'Restart' 'shutdown -r now' -b 'Shutdown'  'shutdown -h now' --background=#005566 --button-background=#009999 --button-border=#002b33 --border-bottom=#002b33";
        };

      };
      style = ''
        * {
        	border: none;
        	border-radius: 10;
          font-family: "JetbrainsMono Nerd Font" ;
        	font-size: 15px;
        	min-height: 10px;
        }

        window#waybar {
        	background: transparent;
        }

        window#waybar.hidden {
        	opacity: 0.2;
        }

        #window {
        	margin-top: 6px;
        	padding-left: 10px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
          color: transparent;
        	background: transparent;
        }
        #workspaces {
        	margin-top: 6px;
        	margin-left: 12px;
        	font-size: 4px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	background: #161320;
        	transition: none;
        }

        #workspaces button {
        	transition: none;
        	color: #B5E8E0;
        	background: transparent;
        	font-size: 16px;
        	border-radius: 2px;
        }

        #workspaces button.occupied {
        	transition: none;
        	color: #F28FAD;
        	background: transparent;
        	font-size: 4px;
        }

        #tags button.focused {
        	color: #ABE9B3;
            border-top: 2px solid #ABE9B3;
            border-bottom: 2px solid #ABE9B3;
        }

        #tags button:hover {
        	transition: none;
        	box-shadow: inherit;
        	text-shadow: inherit;
        	color: #FAE3B0;
            border-color: #E8A2AF;
            color: #E8A2AF;
        }

        #tags button.focused:hover {
            color: #E8A2AF;
        }

        #network {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #bd93f9;
        }

        #pulseaudio {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #1A1826;
        	background: #FAE3B0;
        }

        #battery {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #B5E8E0;
        }

        #battery.charging, #battery.plugged {
        	color: #161320;
            background-color: #B5E8E0;
        }

        #battery.critical:not(.charging) {
            background-color: #B5E8E0;
            color: #161320;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        @keyframes blink {
            to {
                background-color: #BF616A;
                color: #B5E8E0;
            }
        }

        #backlight {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #F8BD96;
        }
        #clock {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #ABE9B3;
        	/*background: #1A1826;*/
        }

        #memory {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	margin-bottom: 0px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #DDB6F2;
        }
        #cpu {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	margin-bottom: 0px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #96CDFB;
        }

        #tray {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	margin-bottom: 0px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
        	color: #B5E8E0;
        	background: #161320;
        }

        #custom-launcher {
        	font-size: 24px;
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 5px;
        	border-radius: 10px;
        	transition: none;
            color: #89DCEB;
            background: #161320;
        }

        #custom-power {
        	font-size: 20px;
        	margin-top: 6px;
        	margin-left: 8px;
        	margin-right: 8px;
        	padding-left: 10px;
        	padding-right: 5px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #F28FAD;
        }

        #custom-wallpaper {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #C9CBFF;
        }

        #custom-updates {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #E8A2AF;
        }

        #custom-media {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #F2CDCD;
        }
      '';
    };
  };
}
