{ inputs, config, ... }:
{
  imports = [
    ../shared
    ./aspects
    ./services
    ./tools
    ./nix.nix
    inputs.home-manager.darwinModules.home-manager
  ];

  system.primaryUser = config.nest.system.mainUser;
}
