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
    inputs.home-manager.nixosModules.home-manager
  ];
}
