
{ lib, config, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.xdg;

in {
    options.${namespace}.system.xdg = {
      enable = mkEnableOption "xdg";
    };
    config = mkIf cfg.enable {
      xdg = {
        enable = true;
        cacheHome = config.home.homeDirectory + "/.local/cache";
        userDirs = {
          enable = true;
          createDirectories = true;
          extraConfig = {
            XDG_BIN_HOME = config.home.homeDirectory + "/bin";
          };
        };
      };
    };
}
