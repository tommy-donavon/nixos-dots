{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf importTOML;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.services.aerospace;
in
{
  options.${namespace}.services.aerospace = {
    enable = mkOpt types.bool true "Whether to enable aerospace wm";
  };

  config = mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      settings = importTOML ./aerospace.toml;
    };
  };
}
