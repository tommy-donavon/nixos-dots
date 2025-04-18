{
  nest.system = {
    mainUser = "tommy";
    users = [ "tommy" ];
  };
  home-manager.users.tommy.nest = {
    programs.terminal.tools.bat.enable = true;
  };
}
