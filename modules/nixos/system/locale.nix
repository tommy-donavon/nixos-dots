{
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.system.locale;

in
{
  options.nest.system.locale = {
    enable = mkEnableOption "locale";
  };

  config = mkIf cfg.enable {

    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

  };
}
