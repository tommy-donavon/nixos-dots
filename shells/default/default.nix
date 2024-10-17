{
  inputs,
  mkShell,
  pkgs,
  system,
  namespace,
  ...
}:
let
  inherit (inputs) snowfall-flake;
in
mkShell {
  packages = with pkgs; [
    hydra-check
    nix-inspect
    nix-bisect
    nix-diff
    nix-health
    nix-index
    # FIXME: broken nixpkgs
    # nix-melt
    nix-prefetch-git
    nix-search-cli
    nix-tree
    nixpkgs-hammering
    nixpkgs-lint
    nixfmt-rfc-style
    snowfall-flake.packages.${system}.flake

    # Adds all the packages required for the pre-commit checks
  ];

  shellHook = ''
    echo 🔨 Welcome to ${namespace}
  '';
}
