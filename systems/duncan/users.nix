{
  inputs',
  self,
  pkgs,
  ...
}:
let
  inherit (self.lib.module) enabled;
in
{
  nest.system = {
    mainUser = "tommy";
    users = [ "tommy" ];
  };
  home-manager.users.tommy = {
    gtk = {
      enable = true;
      cursorTheme = {
        name = "Nordzy-white-cursors";
        package = pkgs.nordzy-cursor-theme;
      };
      iconTheme = {
        name = "kora";
        package = pkgs.kora-icon-theme;
      };
    };
    home.packages = with pkgs; [
      inputs'.zen-browser.packages.default
      zoom-us
      obs-studio
      spotify
    ];
    nest = {
      aspects = {
        common = enabled;
        development = enabled;
      };
      programs = {
        graphical = {
          wofi = enabled;
          hyprpanel = enabled;
        };
        terminal.editors.nvim.package = inputs'.lunavim.packages.default;
        wms.hyprland = enabled;

      };
    };
  };
}
