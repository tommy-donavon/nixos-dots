{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.${namespace}.programs.terminal.emulators.foot;

in
{
  options.${namespace}.programs.terminal.emulators.foot = {
    enable = mkEnableOption "foot";
  };
  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          pad = "12x12";
        };
      };
    };
    home.sessionVariables = {
      Terminal = "foot";
    };
    home.packages = with pkgs; [ neofetch ];
  };
}
