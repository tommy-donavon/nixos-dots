{
  config,
  lib,

  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nest.hardware.nvidia;
in
{
  options.nest.hardware.nvidia = {
    enable = mkEnableOption "nvidia";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;

      nvidiaSettings = true;
    };
  };
}
