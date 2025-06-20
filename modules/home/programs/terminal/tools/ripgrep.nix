{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    ;

  cfg = config.nest.programs.terminal.tools.ripgrep;
in
{
  options.nest.programs.terminal.tools.ripgrep = {
    enable = mkEnableOption "ripgrep";
  };

  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}
