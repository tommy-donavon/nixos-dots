{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.cli.nnn;
in
{
  options.modules.cli.nnn = { enable = mkEnableOption "nnn"; };

  config = mkIf cfg.enable {
    programs.nnn = {
      enable = true;
      package = pkgs.nnn.override ({ withNerdIcons = true; });
      extraPackages = with pkgs; [
        bat
        eza
        ffmpegthumbnailer
        fzf
        imv
        mediainfo
      ];
      plugins = {
        src = "${pkgs.nnn.src}/plugins";
        mappings = {
          c = "fzcd";
          f = "finder";
          o = "fzopen";
          p = "preview-tui";
          t = "nmount";
          v = "imgview";
        };
      };
    };
  };
}
