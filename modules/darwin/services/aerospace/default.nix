{
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib) types mkIf importTOML;
  inherit (self.lib.module) mkOpt;

  cfg = config.nest.services.aerospace;
in
{
  options.nest.services.aerospace = {
    enable = mkOpt types.bool false "Whether to enable aerospace wm";
  };

  config = mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      settings = importTOML ./aerospace.toml;
    };
  };
}
