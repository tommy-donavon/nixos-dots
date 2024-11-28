{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = {
    enable = mkEnableOption "common";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
      killall
      tree
    ];
    nixdots = {
      theme = enabled;

      programs = {
        terminal = {
          tools = {
            btop = enabled;
            bat = enabled;
          };
        };
      };
    };
  };
}
