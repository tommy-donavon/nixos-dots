{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.tools.homebrew;
in
{
  options.${namespace}.tools.homebrew = {
    enable = mkEnableOption "homebrew";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;

      global = {
        brewfile = true;
        autoUpdate = true;
      };

      onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
        upgrade = true;
      };

      taps = [
        "homebrew/bundle"
        "homebrew/services"
      ];
    };
  };

}
