{
  lib,
  config,
  namespace,
  ...
}:

let
  cfg = config.${namespace}.programs.terminal.emulators.ghostty;
  inherit (lib) mkEnableOption mkIf;

in
{
  options.${namespace}.programs.terminal.emulators.ghostty = {
    enable = mkEnableOption "ghostty";
  };
  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      installVimSyntax = true;
      installBatSyntax = true;
    };
  };
}
