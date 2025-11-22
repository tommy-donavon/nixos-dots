{ self, ... }:
let
  inherit (self.lib.helpers) nixFilesIn;
in
{
  imports = nixFilesIn ./. ++ [ ./caelestia ];
}
