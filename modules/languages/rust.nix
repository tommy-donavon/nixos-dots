{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.langs.rust;
in
{
  options.modules.langs.rust = { enable = mkEnableOption "rust"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cargo
      clippy
      rustc
      rustfmt
      rust-analyzer
    ];
  };
}
