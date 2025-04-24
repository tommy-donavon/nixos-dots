{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (self.lib.module) mkOpt;

  cfg = config.nest.programs.terminal.editors.nvim;
in
{
  options.nest.programs.terminal.editors.nvim = {
    enable = mkEnableOption "nvim" // {
      default = true;
    };
    package = mkOpt lib.types.package pkgs.neovim "packaged distribution of neovim to use";
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
