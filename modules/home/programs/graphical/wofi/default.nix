{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.programs.graphical.wofi;
in
{
  options.${namespace}.programs.graphical.wofi = {
    enable = mkEnableOption "wofi";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wofi ];
    home.file.".config/wofi.css".source = ./wofi.css;
  };
}
