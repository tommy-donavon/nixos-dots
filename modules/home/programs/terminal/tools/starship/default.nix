{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf importTOML;

  cfg = config.${namespace}.programs.terminal.tools.starship;
in
{
  options.${namespace}.programs.terminal.tools.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ starship ];
    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
        command_timeout = 1000;

        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[✖](bold red)";
        };
        terraform = {
          format = "[$symbol$version]($style) ";
          style = "105";
        };

        battery = {
          display = [
            {
              threshold = 30;
              style = "bold yellow";
            }
            {
              threshold = 10;
              style = "bold red";
            }
          ];
        };
      };
      # settings = importTOML ./starship.toml;
    };
  };
}
