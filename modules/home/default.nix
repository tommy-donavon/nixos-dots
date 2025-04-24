{ osConfig, ... }:
{
  imports = [ ./direnv.nix ];
  home.stateVersion = osConfig.nest.system.stateVersion;

  programs.home-manager.enable = true;
}
