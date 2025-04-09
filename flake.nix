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
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
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

    stylix.url = "github:danth/stylix/release-24.11";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    zen-browser.url = "github:heywoodlh/flakes/0dd7b48a11af1c4c14632c56c2dc3a4e547f0ed6?dir=zen-browser";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lunavim = {
      url = "github:tommy-donavon/lunavim";
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
      home.modules = with inputs; [
        stylix.homeManagerModules.stylix
        hyprpanel.homeManagerModules.hyprpanel
      ];
      overlays = with inputs; [
        nur.overlays.default
        rust-overlay.overlays.default
        alacritty-theme.overlays.default
        snowfall-frost.overlays."package/frost"
        hyprpanel.overlay
        lunavim.overlays.default
        (_final: prev: {
          unstable = import inputs.unstable {
            inherit (prev) system;
          };
        })
      ];

      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };
}
