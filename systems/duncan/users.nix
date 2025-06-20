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
      iconTheme = {
        name = "kora";
        package = pkgs.kora-icon-theme;
      };
    };
    home.packages = with pkgs; [
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
          rofi = enabled;
          hyprpanel = enabled;
        };
        terminal.editors.nvim.package = inputs'.lunavim.packages.default;
        wms.hyprland = enabled;

      };
      theme.wallpaper = "angel.png";
    };
  };
}
