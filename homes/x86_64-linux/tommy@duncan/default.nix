{ lib, namespace, config, ... }:
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
      desktop = enabled;
      development = enabled;
    };
    #    common = enabled;
    #    desktop = enabled;
  };
  home.stateVersion = "21.11";
}
