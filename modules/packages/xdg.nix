{ lib, config, ... }:

with lib;
let cfg = config.modules.packages.xdg;

in {
    options.modules.packages.xdg = { enable = mkEnableOption "xdg"; };
    config = mkIf cfg.enable {
        xdg.userDirs = {
            enable = true;
            documents = "$HOME/stuff/other/";
            download = "$HOME/stuff/other/";
            videos = "$HOME/stuff/other/";
            music = "$HOME/stuff/music/";
            pictures = "$HOME/stuff/pictures/";
            desktop = "$HOME/stuff/other/";
            publicShare = "$HOME/stuff/other/";
            templates = "$HOME/stuff/other/";
        };
    };
}
