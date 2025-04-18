{ osConfig, ... }:
{
  home.stateVersion = osConfig.nest.system.stateVersion;

  programs.home-manager.enable = true;
}
