{  
  lib,
  namespace, 
  pkgs,
  config,
  ...}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.editors.helix;
in {
  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  options.${namespace}.programs.terminal.editors.helix = { 
  enable = mkBoolOpt false "helix"; 
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      helix
      nodePackages.bash-language-server
    ];

    programs.helix = {
      enable = true;

      settings = {
        theme = "catppuccin_mocha";
        editor = {
          auto-format = true;
          bufferline = "never";
          color-modes = true;
          cursorline = true;
          indent-guides.render = true;
          line-number = "absolute";
          soft-wrap.enable = true;

          # FIXME: remove once https://github.com/helix-editor/helix/issues/1475 is fixed
          # auto-info = false;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          file-picker = {
            hidden = false;
            git-ignore = false;
          };

          statusline = {
            mode.normal = "";
            mode.insert = "";
            mode.select = "";

            left = [ "mode" "spacer" "spinner" "file-name" ];
            right = [
              "diagnostics"
              "position"
              "primary-selection-length"
              "file-encoding"
              "file-type"
              "version-control"
              "spacer"
              "position-percentage"
            ];
          };
        };
      };
    };

  };
}
