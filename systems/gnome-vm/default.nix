{ self, inputs, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [
    inputs.nixos-generators.nixosModules.qcow-efi
  ];

  nest = {
    system = {
      mainUser = "vm";
      users = [ "vm" ];
    };
    aspects = {
      gnome = enabled;
      vm = enabled;
    };
  };

  system.stateVersion = "26.05";
}
