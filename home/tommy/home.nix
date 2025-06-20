{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoom-us
    obs-studio
    spotify
  ];
}
