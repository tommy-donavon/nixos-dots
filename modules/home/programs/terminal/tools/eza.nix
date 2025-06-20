{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.programs.terminal.tools.eza;
in
{
  options.nest.programs.terminal.tools.eza = {
    enable = mkEnableOption "eza";
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      #enableZshIntegration = true;
      git = true;
      icons = "always";
    };
    home.shellAliases = {
      ls = "eza";
      l = "eza -l";
    };
  };
}
