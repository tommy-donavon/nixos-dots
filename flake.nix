{
  description = "dots";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-25.05";
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
      ref = "release-25.05";
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
      ref = "nix-darwin-25.05";
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
      owner = "nix-community";
      repo = "stylix";
      ref = "release-25.05";
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

    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "default";
    };

    wallpapers = {
      type = "github";
      owner = "tommy-donavon";
      repo = "wallpapers";
      flake = false;
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./modules/flake ];
      flake = {
        templates =
          let
            mkTemplate =
              {
                name,
                description,
                path,
                buildTools ? null,
              }:
              {
                inherit path;
                description = name;

                welcomeText = ''
                  # ${name}
                  ${description}

                  ${
                    if buildTools != null then
                      ''
                        ## Build Tools

                        - ${builtins.concatStringsSep "\n- " buildTools}
                      ''
                    else
                      ""
                  }
                  ## Other tips
                  If you use direnv run:

                  ```
                    echo "use flake" > .envrc
                  ```

                '';
              };
          in
          {
            elixir = mkTemplate {
              name = "Elixir Development Shell";
              description = "A development shell for Elixir projects with Hex and Mix2Nix.";
              path = ./templates/elixir;
              buildTools = [
                "elixir"
                "hex"
                "mix2nix"
              ];
            };

          };
      };
    };
}
