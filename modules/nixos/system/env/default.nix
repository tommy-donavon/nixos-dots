{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.env;

in
{
  options.${namespace}.system.env = {
    enable = mkEnableOption "env";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      acpi
      blanket
      dconf
      git
      gimp
      zulu8
      libnotify
      libnotify
      libreoffice-qt
      lowdown
      obs-studio
      tidal-hifi
      tlp
      zip
      unzip
      vesktop
      zk
    ];

    environment.variables = {
      DIRENV_LOG_FORMAT = "";
      DISABLE_QT5_COMPAT = "0";
      DOTS_DIR = "$HOME/dots";
      GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
      GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_CONFIG = "$HOME/dots/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/dots/";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
    };
  };
}
