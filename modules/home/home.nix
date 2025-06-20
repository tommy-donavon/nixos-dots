{ osConfig, inputs, ... }:
{
  imports = [
    inputs.nur.modules.homeManager.default
  ];

  home.stateVersion = osConfig.nest.system.stateVersion;
  programs.home-manager.enable = true;
}
