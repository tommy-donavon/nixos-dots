{
  config,
  lib,
  self,
  ...
}:
let
  inherit (self.lib.module) mkBoolOpt mkOpt;

  cfg = config.nest.aspects.vm;
in
{
  options.nest.aspects.vm = {
    enable = mkBoolOpt false "Configure the system as a QEMU guest VM. Pairs with nest.aspects.gnome.";
    autoLogin = mkBoolOpt true "Automatically log in the main user at GDM.";
    shareTag = mkOpt lib.types.str "dots" "9p virtfs mount tag used by the host launcher for the dots share.";
    shareMountpoint = mkOpt lib.types.str "/mnt/dots" "Guest mountpoint for the shared dots folder.";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.diskSize = 32768;

    services = {
      qemuGuest.enable = true;
      spice-vdagentd.enable = true;
      openssh = {
        enable = true;
        settings.PermitRootLogin = "no";
      };
      displayManager.autoLogin = lib.mkIf cfg.autoLogin {
        enable = true;
        user = config.nest.system.mainUser;
      };
    };

    # workaround for the GNOME + GDM autologin race condition
    systemd.services = lib.mkIf cfg.autoLogin {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };

    fileSystems.${cfg.shareMountpoint} = {
      device = cfg.shareTag;
      fsType = "9p";
      options = [
        "trans=virtio"
        "version=9p2000.L"
        "cache=loose"
        "nofail"
        "msize=104857600"
        "x-systemd.automount"
      ];
    };
  };
}
