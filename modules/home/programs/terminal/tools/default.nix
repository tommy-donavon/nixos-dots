{ self, ... }:
let
  inherit (self.lib.helpers) nixFilesIn;
in
{
  import = nixFilesIn ./.;
}
