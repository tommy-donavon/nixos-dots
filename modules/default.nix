{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "21.03";
  imports = [
    ./dunst
    ./firefox
    ./foot
    ./git
    ./helix
    ./hyprland
    ./packages
    ./waybar
    ./wofi
    ./xdg
    ./zsh
    ./ssh
    ./starship
  ];
}
