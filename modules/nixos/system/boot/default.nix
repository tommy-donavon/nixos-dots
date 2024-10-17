{ config, lib, namespace, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.boot;
in
{
  options.${namespace}.system.boot = {
    enable = mkEnableOption "boot";
  };

  config = mkIf cfg.enable {
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
  };
}
