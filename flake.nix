{
  description = "dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # TODO remove once https://github.com/NixOS/nixpkgs/issues/355377 is resolved
    ghostscript.url = "github:nixos/nixpkgs/aecd17c0dbd112d6df343827d9324f071ef9c502";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-frost = {
      url = "github:snowfallorg/frost";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    zen-browser.url = "github:heywoodlh/flakes/main?dir=zen-browser";
  };

  outputs =
    inputs:
    let
      inherit (inputs) snowfall-lib;

      lib = snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "nixdots";
            title = "nixDots";
          };
          namespace = "nixdots";
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;

      };
      home.modules = with inputs; [ stylix.homeManagerModules.stylix ];
      overlays = with inputs; [
        nur.overlay
        rust-overlay.overlays.default
        alacritty-theme.overlays.default
        (_final: prev: { inherit (inputs.ghostscript.legacyPackages.${prev.system}) ghostscript; })
        snowfall-frost.overlays."package/frost"
      ];

      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };
}
