{
  config,
  lib,

  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.system.boot;
in
{
  options.nest.system.boot = {
    enable = mkEnableOption "boot";
  };

  config = mkIf cfg.enable {
    boot = {
      tmp.cleanOnBoot = true;
      kernelParams = [ "console=tty1" ];
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
