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
  options.nest.system.useHomeManager = mkEnableOption "Whether to use home-manager or not" // {
    default = true;
  };

  config = mkIf config.nest.system.useHomeManager {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = false;
      backupFileExtension = "bak";
      verbose = true;

      # home-manager users
      users = genAttrs config.nest.system.users (name: {
        imports = [ ./${name} ];
      });

      extraSpecialArgs = {
        inherit
          self
          self'
          inputs
          inputs'
          ;
      };

      sharedModules = [
        # shared home-manager modules
        (self + /modules/home/default.nix)
      ];

    };
  };
}
