{ writeShellApplication, ... }:
writeShellApplication {
  name = "powermenu";

  meta = {
    mainProgram = "powermenu";
  };

  text = ''
        op=$(echo -e " Poweroff\n Reboot\n Suspend\n Lock\n" | wofi -i --dmenu --style "$HOME/.config/wofi.css" | awk '{print tolower($2)}')
    case "$op" in 
            poweroff)
                    ;&
            reboot)
                    ;&
            suspend)
                    systemctl "$op"
                    ;;
            lock)
    			    hyprlock
                    ;;
    esac
  '';
}
