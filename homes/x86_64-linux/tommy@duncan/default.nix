{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib.${namespace}) enabled disabled;
in
{

  nixdots = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };
    languages.node = lib.mkForce disabled;
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
