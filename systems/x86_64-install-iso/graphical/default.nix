{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
in
{
  networking.wireless.enable = lib.mkForce false;
  boot.loader.timeout = lib.mkForce 0;
  nixdots = {
    suites = {
      common = enabled;
    };
  };

  nix.enable = true;
  services.openssh.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
    };
  };

  system.stateVersion = "23.11";
}
