{ osConfig, ... }:
{
  imports = [
    ./programs
  ];
  home.stateVersion = osConfig.dots.system.stateVersion;

  programs.home-manager.enable = true;
}
