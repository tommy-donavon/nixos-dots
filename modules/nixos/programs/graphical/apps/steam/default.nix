{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.programs.graphical.apps.steam;
in
{
  options.${namespace}.programs.graphical.apps.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      steamcmd
      steam-tui
      adwsteamgtk
    ];
    programs.steam = {
      enable = true;
    };
  };
}
