{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    ;

  cfg = config.${namespace}.programs.terminal.tools.ripgrep;
in
{
  options.${namespace}.programs.terminal.tools.ripgrep = {
    enable = mkEnableOption "ripgrep";
  };

  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
      package = pkgs.ripgrep;
    };
  };
}
