{ lib, config, ... }:

with lib;
let cfg = config.modules.apps.wofi;

in {
    options.modules.apps.wofi = { enable = mkEnableOption "wofi"; };
    config = mkIf cfg.enable {
        home.file.".config/wofi.css".source = ./wofi.css;
    };
}
