{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.apps.wofi;
  start = pkgs.writeShellScriptBin "powermenu" "${builtins.readFile ./power}";
in
{
  options.modules.apps.wofi = { enable = mkEnableOption "wofi"; };
  config = mkIf cfg.enable {
    home.packages = [
      start
    ];
    home.file.".config/wofi.css".source = ./wofi.css;
  };
}
