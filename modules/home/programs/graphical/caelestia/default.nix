{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.nest.programs.graphical.caelestia;
in
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];
  options.nest.programs.graphical.caelestia = {
    enable = mkEnableOption "caelestia";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      CAELESTIA_WALLPAPERS_DIR = inputs.wallpapers.outPath;
    };
    wayland.windowManager.hyprland = mkIf config.nest.programs.wms.hyprland.enable {
      settings.bind = [
        "SUPER,D,global,caelestia:launcher"
      ];
    };
    programs.caelestia = {
      enable = true;
      cli.enable = true;
      settings = (builtins.readFile ./shell.json |> builtins.fromJSON) // {
        paths = {
          wallpaperDir = inputs.wallpapers.outPath;
        };
      };
    };
  };
}
