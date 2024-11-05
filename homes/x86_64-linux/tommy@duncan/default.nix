{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib.${namespace}) enabled;
in
{

  nixdots = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };
    suites = {
      common = enabled;
      desktop = enabled;
      development = {
        enable = true;
        dataEnable = true;
      };
    };
  };
  home.stateVersion = "21.11";
}
