{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.stable;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
