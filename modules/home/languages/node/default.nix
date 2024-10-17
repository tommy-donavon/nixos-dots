{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.languages.node;
in
{
  options.${namespace}.languages.node = {
    enable = mkEnableOption "node";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs_22
      bun
    ];
  };
}
