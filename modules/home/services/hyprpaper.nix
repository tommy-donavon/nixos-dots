{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;

  cond = pkgs.stdenv.isLinux && config.nest.programs.wms.hyprland.enable;
in
{

  config = mkIf cond {
    services.hyprpaper = {
      enable = true;
      settings.ipc = false;
    };
  };
}
