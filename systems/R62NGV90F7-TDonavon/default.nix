{ self, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  nest = {
    system = {
      mainUser = "tommy.donavon";
      users = [ "tommy.donavon" ];
    };
    aspects = {
      development = enabled;
      laptop = enabled;
    };
    system.stateVersion = "24.11";
  };
}
