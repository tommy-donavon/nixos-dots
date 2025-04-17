{
  lib,
  inputs,
  self,
  ...
}:
let
  inherit (self.lib.module) mkModule;
  inherit (builtins) throw;
in
{
  imports = [
    ../../systems
    ./shell.nix
    ./lib
  ];
  systems = import inputs.systems;

  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      formatter = pkgs.nixfmt-rfc-style;
    };
  debug = true;
  flake = {
    nixosModules = {
      dots = mkModule {
        name = "dots";
        class = "nixos";
        inherit (self) outPath;
        modules = [ ];
      };
    };
    homeManagerModules = {
      dots = mkModule {
        name = "dots";
        class = "homeManager";
        inherit (self) outPath;
        modules = [ (self + /modules/home/default.nix) ];
      };
      default = throw "no default for this module";
    };
  };
}
