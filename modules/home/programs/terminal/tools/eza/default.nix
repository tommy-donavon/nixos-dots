{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.programs.terminal.tools.eza;
in
{
  options.${namespace}.programs.terminal.tools.eza = {
    enable = mkEnableOption "eza";
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "always";
    };
    home.shellAliases = {
      ls = "eza";
      l = "eza -l";
    };
  };
}
