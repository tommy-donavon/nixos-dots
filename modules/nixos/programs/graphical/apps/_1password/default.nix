{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.nest) mkBoolOpt enabled;

  cfg = config.nest.programs.graphical.apps._1password;
in
{
  options.nest.programs.graphical.apps._1password = {
    enable = mkBoolOpt false "Whether or not to enable 1password.";
    enableSshSocket = mkBoolOpt false "Whether or not to enable ssh-agent socket.";
  };

  config = mkIf cfg.enable {
    programs = {
      _1password = enabled;
      _1password-gui = {
        enable = true;
        package = pkgs._1password-gui;

        polkitPolicyOwners = [ config.nest.user.name ];
      };

      ssh.extraConfig = ''
        Host *
          AddKeysToAgent yes
          ${lib.optionalString cfg.enableSshSocket "IdentityAgent ~/.1password/agent.sock"}
      '';
    };
    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          firefox
        '';
        mode = "0755";
      };
    };
  };
}
