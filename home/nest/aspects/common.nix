# tools and programs I tend to use on all systems
{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.nest) enabled;

  cfg = config.nest.suites.common;
in
{
  options.nest.suites.common = {
    enable = mkEnableOption "common";
  };

  config = mkIf cfg.enable {
    # misc packages
    home.packages = with pkgs; [
      bandwhich
      fd
      feh
      gnumake
      killall
      nix-search-cli
      obsidian
      tree
      tui-journal
    ];
    nest = {
      theme = enabled;

      programs = {
        terminal = {
          tools = {
            bat = enabled;
            btop = enabled;
            eza = enabled;
            git = enabled;
            ripgrep = enabled;
            zoxide = enabled;
          };
        };
      };
    };
  };
}
