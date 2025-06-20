{ inputs, ... }:
{
  imports = [
    ../shared
    ./aspects
    ./services
    ./tools
    ./nix.nix
    inputs.home-manager.darwinModules.home-manager
  ];
}
