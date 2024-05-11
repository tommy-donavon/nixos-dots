{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.firefox;

in
{
  options.modules.ssh = { enable = mkEnableOption "ssh"; };

  config = mkIf cfg.enable {
    programs.ssh = {
    enable = true;
    extraConfig = ''
       Host *
          IdentityAgent ~/.1password/agent.sock
    '';
     };
  };
}
