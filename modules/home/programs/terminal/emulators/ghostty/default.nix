{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.terminal.emulators.ghostty;
in
{
  options.${namespace}.programs.terminal.emulators.ghostty = {
    enable = mkEnableOption "ghostty";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ghostty ];
    home.file = {
      ".config/ghostty/config" = {
        text = ''
          font-family = FiraCode Nerd Font
          theme = catppuccin-mocha
          command = /run/current-system/sw/bin/zsh
          click-repeat-interval = 500
          auto-update-channel = tip
        '';
      };
    };
  };
}
