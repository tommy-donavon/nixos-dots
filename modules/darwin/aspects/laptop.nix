{
  config,
  lib,
  self,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (self.lib.module) enabled;

  cfg = config.nest.aspects.laptop;
in
{
  options.nest.aspects.laptop = {
    enable = mkEnableOption "laptop";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = [
        "font-fira-code-nerd-font"
        "obsidian"
      ];
      taps = [ "1password/tap" ];
      brews = [
        "bashdb"
        "gnu-sed"
      ];
    };

    nest = {
      services = {
        #aerospace = enabled;
      };
      tools = {
        homebrew = enabled;
      };
    };

  };
}
