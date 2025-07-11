{
  perSystem =
    {
      pkgs,
      inputs',
      config,
      ...
    }:
    {
      devShells = {
        default =
          pkgs.mkShellNoCC {
            name = "nest";
            meta.description = "dev shell for this config";

            treefmt = config.treefmt.build.wrapper;

            env = {
              DIRENV_LOG_FORMAT = "";
              NH_SKIP_ROOT_CHECK = true;
            };

            packages = with pkgs; [
              hydra-check
              nix-inspect
              nix-bisect
              nix-diff
              nix-health
              nix-index
              nix-melt
              nix-prefetch-git
              nix-search-cli
              nix-tree
              nixpkgs-hammering
              nixpkgs-lint
              nixfmt-rfc-style
              just
              inputs'.nh.packages.default
              cocogitto
              unstable.nil
              home-manager
            ];
            shellHook = ''
              cog install-hook --all -o
              echo Welcome to the nest 🐦
            '';
          }
          // config.treefmt.build.programs;
      };
    };
}
