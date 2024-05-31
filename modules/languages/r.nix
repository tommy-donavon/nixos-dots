{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.langs.r;
  myRPackages = with pkgs.rPackages; [
    caret
    kernlab
    languageserver
    pacman
    snakecase
    tidyverse
  ];
in
{
  options.modules.langs.r = {
    enable = mkEnableOption "r";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (rWrapper.override { packages = myRPackages; })
      (rstudioWrapper.override { packages = myRPackages; })
    ];
  };
}
