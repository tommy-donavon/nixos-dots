{ pkgs, lib, config, ... }:

with lib;
let
  cfg =
    config.modules.packages;
  screenshare = pkgs.writeShellScriptBin "screen" "${builtins.readFile ./scripts/screenshare}";
  powermenu = pkgs.writeShellScriptBin "powermenu" "${builtins.readFile ./scripts/powerbar}";
in
{
  imports = [
    ./foot.nix
    ./xdg.nix
    # ./stylix.nix
  ];

  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      age
      anki-bin
      bat
      catppuccin-sddm
      element-desktop-wayland
      ffmpeg
      fzf
      git
      gnupg
      grim
      htop
      hunspell
      imagemagick
      libnotify
      libreoffice-qt
      lowdown
      lua
      mpv
      neofetch
      obsidian
      obs-studio
      pass
      powermenu
      pqiv
      python3
      ripgrep
      screenshare
      slop
      slurp
      tealdeer
      texlive.combined.scheme-full
      tidal-hifi
      unzip
      upower
      vesktop
      wf-recorder
      zig
      zk
    ];
  };
}
