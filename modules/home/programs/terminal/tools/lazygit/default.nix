
{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.programs.terminal.tools.lazygit;
in
{
  options.${namespace}.programs.terminal.tools.lazygit = {
    enable = mkEnableOption "lazygit";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [lazygit];
    programs.lazygit = {
      enable = true;

      settings = {
        gui = {
          authorColors = {
            "${config.${namespace}.user.fullName}" = "#c6a0f6";
            "dependabot[bot]" = "#eed49f";
          };
          showBottomLine = false;
        };
      };
    };

    home.shellAliases = {
      lg = "lazygit";
    };
  };
}
