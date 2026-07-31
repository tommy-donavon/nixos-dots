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
      R62NGV90F7-Donavon = {
        arch = "aarch64";
        class = "darwin";
      };

      # graphical GNOME VM (aarch64 for Apple Silicon)
      gnome-vm-aarch64 = {
        arch = "aarch64";
        path = "${self}/systems/gnome-vm";
      };

      # graphical GNOME VM (x86_64 for duncan)
      gnome-vm-x86_64 = {
        path = "${self}/systems/gnome-vm";
      };
    };
  };

}
