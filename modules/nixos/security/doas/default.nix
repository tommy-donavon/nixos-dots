{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.security.doas;
in
{
  options.${namespace}.security.doas = {
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
            users = [ config.${namespace}.user.name ];
          }
        ];
      };
    };

  };
}
