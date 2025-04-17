{ lib, ... }:
let
  dotLib = lib.fixedPoints.makeExtensible (final: {
    module = import ./module.nix { inherit lib; };
    helpers = import ./helpers.nix { inherit lib; };
  });
in
{
  flake.lib = dotLib;
}
