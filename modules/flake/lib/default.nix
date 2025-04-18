{ lib, pkgs, ... }:
let
  dotLib = lib.fixedPoints.makeExtensible (final: {
    module = import ./module.nix { inherit lib; };
    helpers = import ./helpers.nix { inherit lib; };
    system = import ./system.nix { inherit pkgs; };
  });
in
{
  flake.lib = dotLib;
}
