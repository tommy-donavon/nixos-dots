{
  inputs,
  ...
}:
{
  imports = [
    ./aspects
    ./hardware
    ./programs
    ./security
    ./services
    ./system
    ./nix.nix
    inputs.home-manager.nixosModules.home-manager
  ];
}
