{
  description = "elixir dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{
      nixpkgs,
      ...
    }:
    let
      overlay = prev: _final: rec {
        beamPackages = prev.beam.packagesWith prev.beam.interpreters.erlang_27;
        elixir = beamPackages.elixir_1_18;
        erlang = prev.erlang_27;
        inherit (beamPackages) hex;
        final.mix2nix = prev.mix2nix.overrideAttrs {
          nativeBuildInputs = [ final.elixir ];
          buildInputs = [ final.erlang ];
        };
      };

      eachSystem =
        f:
        nixpkgs.lib.genAttrs (import inputs.systems) (
          system:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ overlay ];
            };
          in
          f { inherit pkgs system; }
        );

    in
    {
      devShells = eachSystem (
        { pkgs, ... }:
        {
          default =
            let
              opts = with pkgs; lib.optional stdenv.isLinux inotify-tools;
            in
            pkgs.mkShell {
              packages =
                with pkgs;
                [
                  elixir
                  hex
                  mix2nix
                ]
                ++ opts;
              shellHook = ''
                # Set up `mix` to save dependencies to the local directory
                mkdir -p .nix-mix
                mkdir -p .nix-hex
                export MIX_HOME=$PWD/.nix-mix
                export HEX_HOME=$PWD/.nix-hex
                export PATH=$MIX_HOME/bin:$PATH
                export PATH=$HEX_HOME/bin:$PATH

                # BEAM-specific
                export LANG=en_US.UTF-8
                export ERL_AFLAGS="-kernel shell_history enabled"
              '';
            };
        }
      );
    };
}
