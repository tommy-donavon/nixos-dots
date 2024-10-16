{ pkgs, lib, config, namespace, ... }:

with lib;
let
  cfg = config.${namespace}.programs.wms.hyprland;
  start = pkgs.writeShellScriptBin "start" "${builtins.readFile ./start}";

in
{
  options.${namespace}.programs.wms.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      hyprlock
      start
      swaybg
      wl-clipboard
      wlsunset
      xdg-utils
    ];

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  };
}
