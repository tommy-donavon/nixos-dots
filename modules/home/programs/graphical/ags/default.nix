{
  lib,
  config,
  namespace,
  pkgs,
  inputs,
  system,
  ...
}:
with lib;
let
  cfg = config.${namespace}.programs.graphical.ags;
in
{
  imports = [ inputs.ags.homeManagerModules.default ];
  options.${namespace}.programs.graphical.ags = {
    enable = mkEnableOption "ags";
  };

  config = mkIf cfg.enable {
    programs.ags = {
      enable = true;

      extraPackages = with pkgs; [
        inputs.ags.packages.${system}.auth
        inputs.ags.packages.${system}.battery
        inputs.ags.packages.${system}.bluetooth
        inputs.ags.packages.${system}.hyprland
        inputs.ags.packages.${system}.mpris
        inputs.ags.packages.${system}.network
        inputs.ags.packages.${system}.notifd
        inputs.ags.packages.${system}.tray
        inputs.ags.packages.${system}.wireplumber
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}
