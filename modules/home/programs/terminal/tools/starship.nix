{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nest.programs.terminal.tools.starship;
in
{
  options.nest.programs.terminal.tools.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
        command_timeout = 1000;

        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[](bold red)";
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
    };
  };
}
