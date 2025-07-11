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
    dir
    |> readDir
    |> mapAttrs (file: type: if type == "directory" then fetchDir "${dir}/${file}" else type);

  /**
    collect all files of a directory as a list of paths

    # Arguments

    - [dir] directory path
  */
  filesIn =
    dir: dir |> fetchDir |> collect (file: path: if isString path then path else "${dir}/${file}");

  get-files =
    path:
    path
    |> (p: if pathExists p then readDir p else { })
    |> filterAttrs (_: kind: kind == "regular")
    |> mapAttrsToList (name: _: "${path}/${name}");

  /**
    collect all non default nix files in given directory

    # Arguments

    - [dir] directory path
  */
  nixFilesIn =
    path:
    path |> get-files |> filter (file: hasSuffix ".nix" file && (baseNameOf file != "default.nix"));
in
{
  inherit fetchDir filesIn nixFilesIn;
}
