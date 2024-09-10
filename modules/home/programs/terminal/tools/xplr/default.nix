{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.programs.terminal.tools.xplr;
in
{
  options.${namespace}.programs.terminal.tools.xplr = {
    enable = mkEnableOption "xplr";
  };

  config = mkIf cfg.enable {
    programs.xplr = {
      enable = true;
    };

    home.shellAliases = {
      x = "xplr";
    };
  };
}
