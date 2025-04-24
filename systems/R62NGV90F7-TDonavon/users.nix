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
      programs.terminal.editors.nvim.package = inputs'.lunavim.packages.default;
    };
  };
}
