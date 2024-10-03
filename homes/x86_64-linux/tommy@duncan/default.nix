{lib, namespace,config, ...}:
let
  inherit (lib.${namespace}) enabled;
in
{

  nixdots = {
  user = {
    enable = true;
    inherit (config.snowfallorg.user) name;
  };
    common = enabled;
    development = enabled;
    desktop = enabled;
  };
}
