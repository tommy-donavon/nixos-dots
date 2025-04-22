{ self, ... }:
let
  inherit (self.lib.module) disabled;
in
{
  programs.nh = {
    enable = true;
    clean = disabled;
  };
}
