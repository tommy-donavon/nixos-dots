{ pkgs, lib, config, ... }:

with lib;
let
  cfg =
    config.modules.packages;
in
{
  imports = [
    ./foot.nix
    ./xdg.nix
  ];
  
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      age
      anki-bin
      bat
      ffmpeg
      fzf
      git
      gnupg
      grim
      htop
      imagemagick
      libnotify
      lowdown
      mpv
      obsidian
      pass
      pqiv
      python3
      lua
      ripgrep
      slop
      slurp
      tealdeer
      tidal-hifi
      unzip
      wf-recorder
      upower
      zig
      zk
      libsForQt5.dolphin
    ];
  };
}
