{
  description = "dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-flake = {
      url = "github:snowfallorg/flake";
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
    zen-browser.url = "github:MarceColl/zen-browser-flake";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # stylix.url = "github:SomeGuyNamedMay/stylix/wallpaper-refactor";

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
      overlays = with inputs; [
        nur.overlay
        rust-overlay.overlays.default
      ];

      # deploy = lib.mkDeploy { inherit (inputs) self; };
      # outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };
}
