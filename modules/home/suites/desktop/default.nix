{
  config,
  lib,
  namespace,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.suites.desktop;
in
# zoom = pkgs.zoom-us.overrideAttrs (attrs: {
#   nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ pkgs.bbe ];
#   postFixup =
#     ''
#       cp $out/opt/zoom/zoom .
#       bbe -e 's/\0manjaro\0/\0nixos\0\0\0/' < zoom > $out/opt/zoom/zoom
#     ''
#     + (attrs.postFixup or "")
#     + ''
#       sed -i 's|Exec=|Exec=env XDG_CURRENT_DESKTOP="gnome" |' $out/share/applications/Zoom.desktop
#     '';
# });
{
  options.${namespace}.suites.desktop = {
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
      zoom-us
    ];
    nixdots = {
      programs = {
        graphical = {
          wofi = enabled;
          waybar = enabled;
          dunst = enabled;
          ags = enabled;
        };
        wms = {
          hyprland = enabled;
        };
      };
    };
  };
}
