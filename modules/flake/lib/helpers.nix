{ lib, ... }:
let
  inherit (builtins)
    mapAttrs
    baseNameOf
    readDir
    filter
    pathExists
    ;

  inherit (lib)
    collect
    isString
    mapAttrsRecursive
    concatStringsSep
    hasSuffix
    mapAttrsToList
    filterAttrs
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
    dir: collect isString (mapAttrsRecursive (path: _type: concatStringsSep "/" path) (fetchDir dir));

  get-files =
    path:
    let
      entries = if pathExists path then readDir path else { };
      filtered-entries = filterAttrs (_name: kind: kind == "regular") entries;
    in
    mapAttrsToList (name: _kind: "${path}/${name}") filtered-entries;

  /**
    collect all non default nix files in given directory

    # Arguments

    - [dir] directory path
  */
  nixFilesIn =
    path: filter (file: (hasSuffix ".nix" file) && (baseNameOf file != "default.nix")) (get-files path);
in
{
  inherit fetchDir filesIn nixFilesIn;
}
