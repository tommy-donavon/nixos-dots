{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.hardware.nvidia;
in
{
  options.${namespace}.hardware.nvidia = {
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
