{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.user;
in
{
  nixdots = {
    suites = {
      common = enabled;
      development = enabled;
    };

  };

  environment.systemPath = [ "/opt/homebrew/bin" ];

  system.stateVersion = 4;
}
