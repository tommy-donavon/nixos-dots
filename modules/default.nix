{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "21.03";
  imports = [
    ./xdg
    ./wofi
    ./eww
    ./hyprland
    ./dunst
    ./zsh
    ./foot
    ./firefox
    ./packages
    ./helix
    ./git
  ];
}
