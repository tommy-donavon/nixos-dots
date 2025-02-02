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
      bandwhich
      fd
      gnumake
      killall
      obsidian
      tree
      tui-journal
      nix-search-cli
    ];
    nixdots = {
      theme = enabled;

      programs = {
        terminal = {
          tools = {
            bat = enabled;
            btop = enabled;
            eza = enabled;
            zoxide = enabled;
          };
        };
        wms = {
          aerospace = mkIf pkgs.stdenv.isDarwin enabled;
        };
      };
    };
  };
}
