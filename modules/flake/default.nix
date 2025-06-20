{
  inputs,
  ...
}:
{
  imports = [
    ../../systems
    ./formatter.nix
    ./lib
    ./shell.nix
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
        overlays = [
          (_: prev: {
            unstable = import inputs.unstable {
              inherit (prev) system;
            };
          })
        ];
      };
      treefmt.flakeCheck = true;
    };
}
