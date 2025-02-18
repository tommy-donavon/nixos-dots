{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
in
{
  imports = [ ./hardware-configuration.nix ];

  nixdots = {
    suites = {
      common = enabled;
      desktop = enabled;
    };
    services = {
      greetd = enabled;
      xserver = enabled;
      tlp = enabled;
    };
  };

  system.stateVersion = "21.11"; # Did you read the comment?
}
