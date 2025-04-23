{
  config,
  lib,

  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.tools.homebrew;
in
{
  options.nest.tools.homebrew = {
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
