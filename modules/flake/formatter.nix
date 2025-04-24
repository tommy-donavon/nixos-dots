{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { pkgs, config, ... }:
    {
      formatter = config.treefmt.build.wrapper;

      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          taplo.enable = true;
          just.enable = true;

          deadnix.enable = true;
          statix.enable = true;
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
        };
      };
    };
}
