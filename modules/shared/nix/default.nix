{
  config,
  inputs,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib)
    filterAttrs
    isType
    mapAttrs
    mapAttrsToList
    mkDefault
    mkIf
    pipe
    types
    ;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.nix;
in
{
  options.${namespace}.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixVersions.latest "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    # faster rebuilding
    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = mkDefault true;
    };

    # environment = {
    #   etc = with inputs; {
    #     # set channels (backwards compatibility)
    #     "nix/flake-channels/system".source = self;
    #     "nix/flake-channels/nixpkgs".source = nixpkgs;
    #     "nix/flake-channels/home-manager".source = home-manager;

    #     # preserve current flake in /etc
    #     "nixos/flake".source = self;
    #   };

    #   systemPackages = with pkgs; [
    #     cachix
    #     deploy-rs
    #     git
    #     nix-prefetch-git
    #   ];
    # };

    nix =
      let
        mappedRegistry = pipe inputs [
          (filterAttrs (_: isType "flake"))
          (mapAttrs (_: flake: { inherit flake; }))
          (x: x // { nixpkgs.flake = inputs.nixpkgs; })
        ];

        users = [
          "root"
          "@wheel"
          "nix-builder"
          config.${namespace}.user.name
        ];
      in
      {
        inherit (cfg) package;

        gc = {
          automatic = true;
          options = "--delete-older-than 7d";
        };

        # This will additionally add your inputs to the system's legacy channels
        # Making legacy nix commands consistent as well
        nixPath = mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

        optimise.automatic = true;

        # pin the registry to avoid downloading and evaluating a new nixpkgs version every time
        # this will add each flake input as a registry to make nix3 commands consistent with your flake
        registry = mappedRegistry;

        settings = {
          allowed-users = users;
          auto-optimise-store = true;
          builders-use-substitutes = true;
          experimental-features = "nix-command flakes";
          flake-registry = "/etc/nix/registry.json";
          http-connections = 50;
          keep-derivations = true;
          keep-going = true;
          keep-outputs = true;
          log-lines = 50;
          trusted-users = users;



          use-xdg-base-directories = true;
        };
      };
  };
}
