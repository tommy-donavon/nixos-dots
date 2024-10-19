{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf importTOML;

  cfg = config.${namespace}.programs.terminal.tools.starship;
in
{
  options.${namespace}.programs.terminal.tools.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [starship];
    programs.starship = {
      enable = true;

      settings = importTOML ./starship.toml;
    };
  };
}
