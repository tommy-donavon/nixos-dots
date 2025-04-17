{
  lib,
  self,
  self',
  config,
  inputs,
  inputs',
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) genAttrs;
  inherit (lib.options) mkEnableOption;
in
{
  options.dots.system.useHomeManager = mkEnableOption "Whether to use home-manager or not" // {
    default = true;
  };

  config = mkIf config.dots.system.useHomeManager {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users = genAttrs config.dots.system.users (name: ./${name});

      extraSpecialArgs = {
        inherit
          self
          self'
          inputs
          inputs'
          ;
      };

    };
  };
}
