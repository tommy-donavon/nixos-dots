{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf getExe;
  cond = pkgs.stdenv.isLinux && config.nest.programs.graphical.hyprlock.enable;
in
{

  config = mkIf cond {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          before_sleep_cmd = "loginctl lock-session";
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || hyprlock";
          unlock_cmd = "loginctl unlock-session";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "${getExe pkgs.brightnessctl} -s set 10";
            on-resume = "${getExe pkgs.brightnessctl} -r";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };

    };

  };
}
