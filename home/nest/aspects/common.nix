# tools and programs I tend to use on all systems
{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (self.lib.module) enabled;

  cfg = config.nest.aspects.common;
in
{
  options.nest.aspects.common = {
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
        graphical = {
          firefox = enabled;
        };
        terminal = {
          emulators.ghostty = enabled;
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
