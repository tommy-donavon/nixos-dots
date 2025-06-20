{
  self,
  inputs',
  ...
}:
let
  inherit (self.lib.module) enabled;
in
{
  nest.system = {
    mainUser = "tommy.donavon";
    users = [ "tommy.donavon" ];
  };
  home-manager.users."tommy.donavon" = {
    nest = {
      aspects = {
        common = enabled;
        development = {
          enable = true;
          opsEnable = true;
        };
      };
      languages = {
        ruby = enabled;
        node = enabled;
      };
      programs = {
        terminal.editors.nvim.package = inputs'.lunavim.packages.default;
        graphical.firefox.workEnable = true;
      };
      theme.theme = "rose-pine-moon";
    };
  };
}
