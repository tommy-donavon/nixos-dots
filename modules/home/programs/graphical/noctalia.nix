{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.nest.programs.graphical.noctalia;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  options.nest.programs.graphical.noctalia = {
    enable = mkEnableOption "noctalia";
  };

  config = mkIf cfg.enable {
    home.file.".cache/noctalia/wallpapers.json" = {
      text = builtins.toJSON {
        defaultWallpaper = "${inputs.wallpapers}/${config.nest.theme.wallpaper}";
      };
    };
    programs.noctalia-shell = {
      enable = true;
      settings = {
        bar = {
          density = "compact";
          position = "left";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          avatarImage = "${config.home.homeDirectory}/.face";
          radiusRatio = 0.2;
        };
        location = {
          useFahrenheit = true;
          monthBeforeDay = true;
          name = "Salt Lake City, UT";
        };
        wallpaper = {
          directory = inputs.wallpapers.outPath;
        };
      };
    };

    wayland.windowManager.hyprland = mkIf config.nest.programs.wms.hyprland.enable {
      settings = {
        bind = [
          "SUPER,D,exec,noctalia-shell ipc call launcher toggle"
        ];
        exec-once = [
          "noctalia-shell"
        ];
      };
    };
  };
}
