{
  self,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkDefault;
  inherit (self.lib.system) systemTernary;

  cfg = config.nest.system;
in
{
  options.nest.system.stateVersion = mkOption {
    internal = true;
    type = lib.types.str;
    default = "23.11";
  };

  config.system = {
    stateVersion = mkDefault (systemTernary pkgs cfg.stateVersion 4);

  };

}
