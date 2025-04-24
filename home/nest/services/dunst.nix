{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.nest.services.dunst;
in
{
  options.nest.services.dunst = {
    enable = mkEnableOption "dunst";
  };

  config = mkIf cfg.enable {
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
          idle_threshold = 120;
          line_height = 0;
          format = "<b>%s</b>\n%b";
          alignment = "center";
          icon_position = "off";
          startup_notification = "false";
          corner_radius = 12;
          timeout = 2;
        };
      };
    };
  };
}
