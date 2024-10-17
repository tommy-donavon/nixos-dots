{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.languages.go;
in
{
  options.${namespace}.languages.go = {
    enable = mkEnableOption "go";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      golangci-lint
      go
      #gotools
    ];
  };
}
