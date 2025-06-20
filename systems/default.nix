{
  inputs,
  self,
  ...
}:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    perClass = class: {
      modules = [
        "${self}/modules/${class}/default.nix"
      ];
    };
    hosts = {

      # personal machine
      duncan = { };

      # work stuffs
      R62NGV90F7-TDonavon = {
        arch = "aarch64";
        class = "darwin";
      };
    };
  };

}
