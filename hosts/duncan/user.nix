{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    apps = {
      dunst.enable = true;
      firefox.enable = true;
      helix.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      wofi.enable = true;
    };

    cli = {
      git = {
        enable = true;
        ui.enable = true;
      };
      nnn.enable = true;
      starship.enable = true;
      terraform.enable = true;
    };

    packages = {
      enable = true;
      foot.enable = true;
      xdg.enable = true;
      # stylix.enable = true;
    };

    langs = {
      r.enable = true;
      rust.enable = true;
      elixir.enable = true;
    };

    shells.zsh.enable = true;
  };
}
