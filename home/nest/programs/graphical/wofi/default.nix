{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.programs.graphical.wofi;
in
{
  options.nest.programs.graphical.wofi = {
    enable = mkEnableOption "wofi";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wofi
    ];
    home.file.".config/wofi.css".source = ./wofi.css;
  };
}
