{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.cli.starship;

in
{
  options.modules.cli.starship = { enable = mkEnableOption "starship"; };
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ./starship.toml;
    };
  };
}
