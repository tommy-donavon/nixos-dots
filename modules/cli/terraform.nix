{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.cli.terraform;
in
{
  options.modules.cli.terraform = { enable = mkEnableOption "terraform"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      terraform
      tfswitch
    ];
  };
}
