{
  lib,
  inputs,
  self,
  ...
}:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    perClass = class: {
      modules = [
        "${self}/users/default.nix"
        inputs.home-manager.nixosModules.home-manager
      ];
    };
    hosts = {

      # personal machine
      duncan = { };
    };
  };

}
