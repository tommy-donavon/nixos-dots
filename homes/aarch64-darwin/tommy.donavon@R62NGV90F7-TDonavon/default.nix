{ config, ... }:
{
  nixdots = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };

    suites = {
      development = {
        enable = true;
        opsEnable = true;
      };
    };
  };
  home.sessionPath = [ "$HOME/.nix-profile/bin" ];

  home.stateVersion = "21.11";
}
