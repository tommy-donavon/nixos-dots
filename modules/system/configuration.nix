{ config, pkgs, lib, inputs, ... }:

{
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  programs.zsh.enable = true;

  # Laptop-specific packages (the other ones are installed in `packages.nix`)
  environment.systemPackages = with pkgs; [
    acpi
    tlp
    git
  ];

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig = {
      enable = true;
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
      };
    };
  };

  xdg = {
    portal = {

      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config.common.default = "*";
    };
  };

  environment.variables = {
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    DISABLE_QT5_COMPAT = "0";
    EDITOR = "nvim";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_CONFIG = "$HOME/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/nixos/";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    Terminal = "foot";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "tommy" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  networking = {
    wireless.iwd.enable = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set up user and enable sudo
  users.users.tommy = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" ];
    shell = pkgs.zsh;
  };

  # Security 
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "tommy" ];
        keepEnv = true;
        persist = true;
      }];
    };

    # Extra security
    protectKernelImage = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
      '';
      mode = "0755";
    };
  };

  # Sound
  sound = {
    enable = true;
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.xserver.desktopManager.gnome.enable = false;
  # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Do not touch
  system.stateVersion = "20.09";

}
