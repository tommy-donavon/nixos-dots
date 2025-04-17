{ lib, ... }:
let
  inherit (builtins)
    mapAttrs
    baseNameOf
    readDir
    filter
    ;

  inherit (lib)
    collect
    isString
    mapAttrsRecursive
    concatStringsSep
    hasSuffix
    ;

  /**
    return all files in given directory as attribute set

    # Arguments

    - [dir] directory path
  */
  fetchDir =
    dir:
    mapAttrs (file: type: if type == "directory" then fetchDir "${dir}/${file}" else type) (
      readDir dir
    );

  /**
    collect all files of a directory as a list of paths

    # Arguments

    - [dir] directory path
  */
  filesIn =
    dir: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (fetchDir dir));

  /**
    collect all non default nix files in given directory

    # Arguments

    - [dir] directory path
  */
  nixFilesIn =
    dir:
    map (file: "/${file}") (
      filter (file: hasSuffix ".nix" file && (baseNameOf file != "default.nix")) (filesIn dir)
    );
in
{
  inherit fetchDir filesIn nixFilesIn;
}
