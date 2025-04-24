{ lib, ... }:
let
  inherit (lib) mkOption types;

  /**
    create a nix module option

    # Arguments

    - [type] the type of the option
    - [default] default value for option
    - [description] succinct description of option

    # Example

    ```nix
    mkOpt lib.types.str "My default" "Description of my option."
    ```
  */
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  /**
    create a nix module option without a description

    # Arguments

    - [type] the type of the option
    - [default] default value for option

    # Example

    ```nix
    mkOpt' lib.types.str "My default"
    ```
  */
  mkOpt' = type: default: mkOpt type default null;

  /**
    create a boolean nix module option with description

    # Arguments

    - [default] default value of option
    - [description] succinct description of option

    # Example

    ```nix
    mkBoolOpt true "My default"
    ```
  */
  mkBoolOpt = mkOpt types.bool;

  /**
    create a boolean nix module option

    # Arguments
    - [default] default value of option

    # Example

    ```nix
    mkBoolOpt' true
    ```
  */
  mkBoolOpt' = mkOpt' types.bool;

  /**
    create nix module config

    # Arguments
    - [name] name of the config
    - [outPath] flake path of the outputted module
    - [class] class name (nixos, darwin)
    - [modules] list of file paths to import

    # Arguments
    - [default] default value of option

    # Example

    ```nix
    mkBoolOpt' true
    ```
  */
  mkModule =
    {
      name,
      class,
      outPath,
      modules,
    }:
    {
      _class = class;
      _file = "${outPath}/flake.nix#${class}Modules.${name}";

      imports = modules;
    };

  /**
    quickly enable an option

    # Example

    ```nix
    services.nginx = enabled;
    ```
  */
  enabled = {
    enable = true;
  };

  /**
    quickly disable an option

    # Example

    ```nix
    services.nginx = disabled;
    ```
  */
  disabled = {
    enable = false;
  };

in
{
  inherit
    disabled
    enabled
    mkBoolOpt
    mkBoolOpt'
    mkModule
    mkOpt
    mkOpt'
    ;
}
