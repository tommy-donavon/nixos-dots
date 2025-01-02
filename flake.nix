{
  description = "dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
      url = "github:nix-community/home-manager/release-24.11";
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

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
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
        snowfall-frost.overlays."package/frost"
        (final: prev: {
          ghostty = inputs.ghostty.packages.${prev.system}.default;
        })
      ];

      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };
}
