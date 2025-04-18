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
  inherit (self.lib.system) ldTernary;

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
    stateVersion = mkDefault (ldTernary pkgs cfg.stateVersion 6);

  };
}
