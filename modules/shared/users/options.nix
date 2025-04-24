{ lib, config, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.lists) optionals;
  inherit (lib.types) enum listOf str;
in
{
  options.nest.system = {
    mainUser = mkOption {
      type = enum config.nest.system.users;
      description = "The username of the main user for your system";
      default = builtins.elemAt config.nest.system.users 0;
    };

    users = mkOption {
      type = listOf str;
      default = [ "tommy" ];
      description = ''
        A list of users that you wish to declare as your non-system users. The first username
        in the list will be treated as your main user unless {option}`nest.system.mainUser` is set.
      '';
    };
  };

  config.warnings = optionals (config.nest.system.users == [ ]) [
    ''
      You have not added any users to be supported by your system. You may end up with an unbootable system!

      Consider setting {option}`config.nest.system.users` in your configuration
    ''
  ];
}
