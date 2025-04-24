{
  config,
  lib,
  pkgs,

  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.programs.graphical.apps.steam;
in
{
  options.nest.programs.graphical.apps.steam = {
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
