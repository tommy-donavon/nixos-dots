{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkAfter;

  cfg = config.nest.programs.graphical.rofi;
in
{
  options.nest.programs.graphical.rofi = {
    enable = mkEnableOption "rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "drun,run,filebrowser";
        show-icons = true;
        display-drun = " APPS";
        display-run = "󰲌 RUN";
        display-filebrowser = " FILES";
        drun-display-format = "{name}";
        window-format = "{w} · {c}";
      };

      # extend stylix theme
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        mkAfter {
          "*" = {
            lines = 6;
            columns = 1;
            cycle = false;
          };

          "window" = {
            transparency = "real";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            fullscreen = false;
            width = mkLiteral "680px";
            x-offset = mkLiteral "0px";
            y-offset = mkLiteral "0px";

            enabled = true;
            border = mkLiteral "2px solid";
            border-radius = mkLiteral "15px";
            border-color = mkLiteral "@alternate-normal-background";
            cursor = "default";
          };

          "mainbox" = {
            enabled = true;
            spacing = mkLiteral "0px";
            background-color = mkLiteral "transparent";
            orientation = mkLiteral "vertical";
            children = builtins.map mkLiteral [
              "inputbar"
              "listbox"
            ];
          };

          "listbox" = {
            spacing = mkLiteral "20px";
            padding = mkLiteral "20px";
            background-color = mkLiteral "transparent";
            orientation = mkLiteral "vertical";
            children = builtins.map mkLiteral [
              "message"
              "listview"
            ];
          };

          "inputbar" = {
            enabled = true;
            spacing = mkLiteral "10px";
            padding = mkLiteral "50px 30px";
            background-color = mkLiteral "transparent";
            background-image = mkLiteral "url(\"${config.stylix.image}\", width)";
            orientation = mkLiteral "horizontal";
            children = builtins.map mkLiteral [
              "textbox-prompt-colon"
              "entry"
              "dummy"
              "mode-switcher"
            ];
          };
          "textbox-prompt-colon" = {
            enabled = true;
            expand = false;
            str = " :";
            padding = mkLiteral "12px 15px";
            border-radius = mkLiteral "100%";
            background-color = mkLiteral "@alternate-normal-background";
            text-color = mkLiteral "inherit";
          };
          "entry" = {
            enabled = true;
            expand = false;
            width = mkLiteral "250px";
            padding = mkLiteral "12px 16px";
            border-radius = mkLiteral "100%";
            background-color = mkLiteral "@alternate-normal-background";
            cursor = mkLiteral "text";
            placeholder = "Search";
            placeholder-color = mkLiteral "inherit";
          };
          "dummy" = {
            expand = true;
            background-color = mkLiteral "transparent";
          };
          "mode-switcher" = {
            enabled = true;
            spacing = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
          };
          "button" = {
            width = mkLiteral "75px";
            padding = mkLiteral "0px";
            border-radius = mkLiteral "100%";
            background-color = mkLiteral "@alternate-normal-background";
            cursor = mkLiteral "pointer";
          };
          "listview" = {
            enabled = true;
            columns = mkLiteral "@columns";
            lines = mkLiteral "@lines";
            cycle = mkLiteral "@cycle";
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = true;
            fixed-columns = true;

            spacing = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
            cursor = "default";
          };
          "element" = {
            enabled = true;
            spacing = mkLiteral "5px";
            padding = mkLiteral "10px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            cursor = mkLiteral "pointer";
          };
          "element-icon" = {
            size = mkLiteral "32px";
            cursor = mkLiteral "inherit";
          };
          "element-text" = {
            highlight = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "message" = {
            background-color = mkLiteral "transparent";
          };
          "textbox" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "15px";
            background-color = mkLiteral "@alternate-normal-background";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "error-message" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "15px";
            background-color = mkLiteral "@background";
            text-color = mkLiteral "@foreground";
          };
        };
    };
  };
}
