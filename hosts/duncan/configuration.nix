{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.thunar.enable = true;
  programs.xfconf.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  environment.systemPackages = with pkgs; [
    acpi
    tlp
    git
    adobe-reader
  ];

  virtualisation.docker.enable = true;

  services.fprintd.enable = true;
  services.blueman.enable = true;

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      unifont
      noto-fonts-monochrome-emoji

      (nerdfonts.override { fonts = [ "JetBrainsMono" "SpaceMono" ]; })
    ];

    fontconfig = {
      enable = true;
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" "Noto Color Emoji" "Unifont" "Noto Monochrome Emoji" ];
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
      config.common.default = "*";
    };
  };

  programs.xwayland.enable = true;

  environment.variables = {
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    DISABLE_QT5_COMPAT = "0";
    EDITOR = "hx";
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

    networkmanager.enable = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    initrd.availableKernelModules = [ "hid_cherry" ];
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

  nixpkgs.config.permittedInsecurePackages = [
    "adobe-reader-9.5.5"
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;

    polkitPolicyOwners = [ "tommy" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
      '';
      mode = "0755";
    };
  };

  programs.ssh = {
    # enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };

  # Sound
  sound = {
    enable = true;
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.xserver = {
    desktopManager.gnome.enable = false;
    videoDrivers = [ "nvidia" ];

    desktopManager.xterm.enable = false;
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;

      nvidiaSettings = true;
    };
  };

  # Do not touch
  system.stateVersion = "20.09";

}
