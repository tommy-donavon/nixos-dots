{
  config,
  lib,
  namespace,
  system,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = {
    enable = mkEnableOption "common";
  };

  config = mkIf cfg.enable {

    environment = {
      systemPackages = [ inputs.zen-browser.packages.${system}.zen-browser ];
    };

    homebrew = {
      casks = [ "font-fira-code-nerd-font" ];
      taps = [ "1password/tap" ];
      brews = [
        "bashdb"
        "gnu-sed"
      ];
    };

    nixdots = {
      tools = {
        homebrew = enabled;
      };
    };

  };
}
