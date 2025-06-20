{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (self.lib.module) mkOpt;

  cfg = config.nest.programs.terminal.tools.lazygit;
  authorColors = cfg.commitColors // {
    "dependabot[bot]" = "#eed49f";
  };
in
{
  options.nest.programs.terminal.tools.lazygit = {
    enable = mkEnableOption "lazygit";
    commitColors = mkOpt lib.types.attrs { } "color to highlight specific commit author";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ lazygit ];
    programs.lazygit = {
      enable = true;

      settings = {
        gui = {
          inherit authorColors;
          showBottomLine = false;
          nerdFontsVersion = "3";
        };
      };
    };

    home.shellAliases = {
      lg = "lazygit";
    };
  };
}
