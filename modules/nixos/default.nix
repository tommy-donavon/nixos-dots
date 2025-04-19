{
  lib,
  self,
  pkgs,
  config,
  inputs,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkDefault;
  inherit (self.lib.system) systemTernary;

  cfg = config.nest.system;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  options.nest.system.stateVersion = mkOption {
    type = lib.types.str;
    default = "23.11";
  };

  config.system = {
    stateVersion = mkDefault (systemTernary pkgs cfg.stateVersion 6);

  };
}
