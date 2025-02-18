{
  lib,
  namespace,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.editors.lunavim;
in
{
  options.${namespace}.programs.terminal.editors.lunavim = {
    enable = mkBoolOpt false "lunavim";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ lunavim ];
    home.sessionVariables = {
      EDITOR = "lunavim";
    };
  };
}
