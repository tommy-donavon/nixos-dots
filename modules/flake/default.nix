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
  flake =
    let
      name = "nest";
      inherit (self) outPath;
    in
    {
      nixosModules = {
        nest = mkModule {
          inherit name outPath;
          class = "nixos";
          modules = [
            (self + /modules/shared/default.nix)
            (self + /modules/nixos/default.nix)
          ];
        };
        default = throw "no default for this module";
      };
      homeManagerModules = {
        nest = mkModule {
          inherit name outPath;
          class = "homeManager";
          modules = [ (self + /modules/home/default.nix) ];
        };
        default = throw "no default for this module";
      };
    };
}
