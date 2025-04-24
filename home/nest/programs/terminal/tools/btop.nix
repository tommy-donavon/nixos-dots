{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.programs.terminal.tools.btop;
in
{
  options.nest.programs.terminal.tools.btop = {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
}
