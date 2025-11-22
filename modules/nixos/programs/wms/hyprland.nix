{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.programs.wms.hyprland;
in
{
  options.nest.programs.wms.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };
}
