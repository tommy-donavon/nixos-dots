{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkEnableOption mkIf;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.programs.terminal.emulators.alacritty;
in
# font = "FiraCode Nerd Font Mono";
{
  options.${namespace}.programs.terminal.emulators.alacritty = with types; {
    enable = mkEnableOption "alacritty";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty;

      settings =
        {
          import = [ pkgs.alacritty-theme.catppuccin_mocha ];
          cursor = {
            style = {
              shape = "Block";
              blinking = "Off";
            };
          };

          colors = {
            draw_bold_text_with_bright_colors = true;
          };

          font = {
            #  size = 17.0;

            offset = {
              x = 0;
              y = 0;
            };

            glyph_offset = {
              x = 0;
              y = 0;
            };

            #  normal = {
            #    family = font;
            #  };
            #  bold = {
            #    family = font;
            #    style = "Bold";
            #  };
            #  italic = {
            #    family = font;
            #    style = "italic";
            #  };
            #  bold_italic = {
            #    family = font;
            #    style = "bold_italic";
            #  };
          };

          keyboard = {
            bindings = [
              {
                key = "C";
                mods = "Super";
                action = "Copy";
              }
              {
                key = "V";
                mods = "Super";
                action = "Paste";
              }
              {
                key = "F1";
                action = "IncreaseFontSize";
              }
              {
                key = "F2";
                action = "DecreaseFontSize";
              }
              {
                key = "F3";
                action = "ResetFontSize";
              }
            ];
          };

          mouse = {
            hide_when_typing = true;
          };

          window = {
            padding = {
              x = 0;
              y = 0;
            };
            opacity = 0.98;
          };
        }
        // lib.optionalAttrs pkgs.stdenv.isLinux { window.decorations = "None"; }
        // lib.optionalAttrs pkgs.stdenv.isDarwin { window.decorations = "Buttonless"; };
    };
  };
}