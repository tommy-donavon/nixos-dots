{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.stable;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      interval = {
        Hour = 3;
        Minute = 15;
      };
    };
  };
}
