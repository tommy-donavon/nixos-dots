{
  perSystem =
    {
      lib,
      pkgs,
      self',
      config,
      inputs',
      ...
    }:
    {
      devShells = {
        default = pkgs.mkShellNoCC {
          name = "dots";
          meta.description = "dev shell for this config";

          env = {
            DIRENV_LOG_FORMAT = "";
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
            nh
            cocogitto
            nil
            home-manager
          ];
          shellHook = ''
            cog install-hook --all -o
            echo 🔨 Welcome to dots 
          '';
        };
      };
    };
}
