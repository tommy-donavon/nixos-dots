{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkForce;
  inherit (lib.${namespace}) enabled disabled;
in
{
  nixdots = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };

    # programs = {
    #   terminal = {
    #     tools = {
    #       lazygit.enable = true;
    #     };
    #     shells = {
    #       zsh.enable = true;
    #     };
    #   };
    # };
    suites = {
      development = {
        enable = true;

        # nixEnable = true;
      };
    };

    # theme.catppuccin = enabled;
  };
  home.sessionPath = [ "$HOME/.nix-profile/bin" ];


  home.stateVersion = "21.11";
}
