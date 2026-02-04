{ inputs, self, ... }:
let
  inherit (self.lib.module) enabled;
in
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { pkgs, config, ... }:
    {
      formatter = config.treefmt.build.wrapper;

      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          taplo = enabled;
          just = enabled;

          deadnix = enabled;
          statix = enabled;
          zizmor = enabled;
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
        };
      };
    };
}
