{ self, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [
    ./users.nix
  ];
  nest = {
    aspects = {
      development = enabled;
      laptop = enabled;
    };
    system.stateVersion = "24.11";
  };
}
