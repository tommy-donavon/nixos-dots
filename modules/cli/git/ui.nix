{ lib, config, ... }:

with lib;
let
  cfg = config.modules.cli.git.ui;
in
{
  options.modules.cli.git.ui = { enable = mkEnableOption "ui"; };
  config = mkIf cfg.enable {

    programs.lazygit = {
      enable = true;

      settings = {
        git.paging.colorArg = "always";
        gui = {
          showBottomLine = false;
        };
      };
    };
  };
}
