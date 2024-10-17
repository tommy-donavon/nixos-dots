{
  lib,
  config,
  namespace,
  pkgs,
  inputs,
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
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}
