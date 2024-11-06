
{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.user;

in
{
  options.${namespace}.user = {
    name = mkOpt types.str "tommy.donavon" "The user account.";

    fullName = mkOpt types.str "Tommy Donavon" "The full name of the user.";
    email = mkOpt types.str "tommy.donavon@hey.com" "The email of the user.";

    uid = mkOpt (types.nullOr types.int) 501 "The uid for the user account.";
    create = mkBoolOpt false "create this user";
  };

  config = {
    users.users.${cfg.name} = {
      # NOTE: Setting the uid here is required for another
      # module to evaluate successfully since it reads
      # `users.users.${plusultra.user.name}.uid`.
      uid = mkIf (cfg.uid != null) cfg.uid;
    };

    snowfallorg.users.${config.${namespace}.user.name}.home.config = {
      home = {
        file = {
          ".profile".text = ''
            # The default file limit is far too low and throws an error when rebuilding the system.
            # See the original with: ulimit -Sa
            ulimit -n 4096
          '';
        };
      };
    };
  };
}
