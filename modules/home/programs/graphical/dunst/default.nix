{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.programs.graphical.dunst;
in
{
  options.${namespace}.programs.graphical.dunst = {
    enable = mkEnableOption "dunst";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ dunst ];

    services.dunst = {
      enable = true;
      settings = {
        global = {
          origin = "top-left";
          offset = "60x12";
          separator_height = 2;
          padding = 12;
          horizontal_padding = 12;
          text_icon_padding = 12;
          frame_width = 4;
          #         separator_color = "frame";
          idle_threshold = 120;
          #        font = "JetBrainsMono Nerdfont 12";
          line_height = 0;
          format = "<b>%s</b>\n%b";
          alignment = "center";
          icon_position = "off";
          startup_notification = "false";
          corner_radius = 12;

          #        frame_color = "#44465c";
          #        background = "#303241";
          #        foreground = "#d9e0ee";
          timeout = 2;
        };
      };
    };
  };
}
