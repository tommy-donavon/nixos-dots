{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.languages.node;
in
{
  options.nest.languages.node = {
    enable = mkEnableOption "node";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs_22
      bun
    ];
  };
}
