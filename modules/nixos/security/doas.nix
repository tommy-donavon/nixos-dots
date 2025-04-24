{
  config,
  lib,
  self,
  ...
}:
let
  inherit (self.lib.module) mkBoolOpt;

  cfg = config.nest.security.doas;
in
{
  options.nest.security.doas = {
    enable = mkBoolOpt false "Whether or not to replace sudo with doas.";
  };

  config = lib.mkIf cfg.enable {
    # Add an alias to the shell for backward-compat and convenience.
    environment.shellAliases = {
      sudo = "doas";
    };

    security = {
      rtkit.enable = true;

      # Disable sudo
      sudo.enable = false;

      # Enable and configure `doas`.
      doas = {
        enable = true;

        extraRules = [
          {
            keepEnv = true;
            noPass = true;
            users = [ config.nest.system.mainUser ];
          }
        ];
      };
    };

  };
}
