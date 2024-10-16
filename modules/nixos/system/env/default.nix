{ pkgs, lib, config, namespace,inputs,system, ... }:

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
      tlp
      git
      inputs.zen-browser.packages."${system}".default
    ];

    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          firefox
        '';
        mode = "0755";
      };
    };
    # TODO move these to a better area
    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

    environment.variables = {
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      DISABLE_QT5_COMPAT = "0";
      DOTS_DIR = "$HOME/dots";
      EDITOR = "nvim";
      GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
      GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_CONFIG = "$HOME/dots/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/dots/";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      Terminal = "foot";
      ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
    };
  };
}
