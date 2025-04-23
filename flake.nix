{
  description = "dots";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-24.11";
    };

    unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    easy-hosts = {
      type = "github";
      owner = "tgirlcloud";
      repo = "easy-hosts";
    };

    darwin = {
      type = "github";
      owner = "lnl7";
      repo = "nix-darwin";
      ref = "nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      type = "github";
      owner = "nix-community";
      repo = "nh";
    };

    nur = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
    };

    stylix = {
      type = "github";
      owner = "danth";
      repo = "stylix";
      ref = "release-24.11";
    };

    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
    };

    lunavim = {
      type = "github";
      owner = "tommy-donavon";
      repo = "lunavim";
    };

    hyprpanel = {
      type = "github";
      owner = "Jas-SinghFSU";
      repo = "HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:heywoodlh/flakes/0dd7b48a11af1c4c14632c56c2dc3a4e547f0ed6?dir=zen-browser";

    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "default";
    };
  };

  outputs =
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } { imports = [ ./modules/flake ]; };
}
