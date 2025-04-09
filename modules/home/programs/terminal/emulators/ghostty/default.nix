{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:

let
  cfg = config.${namespace}.programs.terminal.emulators.ghostty;
  inherit (lib) mkEnableOption mkIf mkMerge;

in
{
  options.${namespace}.programs.terminal.emulators.ghostty = {
    enable = mkEnableOption "ghostty";
  };
  config = mkIf cfg.enable (mkMerge [
    {

      programs.ghostty = {
        enable = true;

        installVimSyntax = true;
        installBatSyntax = true;
      };
    }
    # TODO remove this gross hack after repository refactor is done.
    (mkIf pkgs.stdenv.isDarwin {
      programs.ghostty.package = pkgs.runCommand "dummy-ghostty" { } "mkdir -p $out";
    })

  ]);
}
