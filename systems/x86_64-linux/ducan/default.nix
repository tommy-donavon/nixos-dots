{lib, namespace, ...}:
let
  inherit (lib.${namespace}) enabled;
in
{
  imports = [./hardware-configuration.nix];

    boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    initrd.availableKernelModules = [ "hid_cherry" ];
  };
  system.stateVersion = "21.11"; # Did you read the comment?
}
