{ self, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [
    ./hardware.nix
    ./users.nix
  ];
  nest = {
    aspects = {
      desktop = enabled;
      laptop = enabled;
    };
    services = {
      greetd = enabled;
      xserver = enabled;
      tlp = enabled;
    };
    nix = enabled;
  };
}
