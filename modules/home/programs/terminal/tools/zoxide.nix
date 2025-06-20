{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nest.programs.terminal.tools.zoxide;
in
{
  options.nest.programs.terminal.tools.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      #      enableZshIntegration = true;
    };

    home.shellAliases = {
      cd = "z";
    };
  };
}
