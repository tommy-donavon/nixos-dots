{ config, lib, inputs, ...}:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    foot.enable = true; 
    git.enable = true;
    zsh.enable = true;
    eww.enable = true;
    dunst.enable = true;
    hyprland.enable = true;
    wofi.enable = true;
    xdg.enable = true;
    firefox.enable = true;
    packages.enable = true;
    helix.enable = true;
  };
}
