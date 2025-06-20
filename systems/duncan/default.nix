{ self, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [
    ./hardware.nix
  ];

  nest = {
    system = {
      mainUser = "tommy";
      users = [ "tommy" ];
    };
    aspects = {
      desktop = enabled;
      laptop = enabled;
    };
    services = {
      greetd = enabled;
      xserver = enabled;
      tlp = enabled;
    };
  };
}
