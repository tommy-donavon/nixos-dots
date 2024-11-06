{
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) enabled;
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
