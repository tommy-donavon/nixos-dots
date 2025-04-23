{ inputs, ... }:
{
  imports = [
    ./aspects
    ./services
    ./tools
    inputs.home-manager.darwinModules.home-manager
  ];
}
