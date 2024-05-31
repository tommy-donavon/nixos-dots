{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.apps.hyprland;
  start = pkgs.writeShellScriptBin "start" "${builtins.readFile ./start}";

in
{
  options.modules.apps.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      hyprlock
      start
      swaybg
      wl-clipboard
      wlsunset
      wofi
      xdg-utils
    ];

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  };
}
