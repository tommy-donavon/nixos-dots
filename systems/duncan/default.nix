{ self, pkgs, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [
    ./hardware.nix
    ./users.nix
  ];
  environment.systemPackages = [ (pkgs.writeShellScriptBin "sudo" "doas $@") ];
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
  };
}
