{ config, lib, inputs, ...}:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    dunst.enable = true;
    firefox.enable = true;
    foot.enable = true; 
    git.enable = true;
    helix.enable = true;
    hyprland.enable = true;
    packages.enable = true;
    waybar.enable = true;
    wofi.enable = true;
    xdg.enable = true;
    zsh.enable = true;
    ssh.enable = true;
  };
}
