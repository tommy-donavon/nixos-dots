{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (lib.modules) mkDefault;
  inherit (lib.attrsets) genAttrs;
  inherit (self.lib.system) ldTernary;

in
{
  users.users = genAttrs config.nest.system.users (
    name:
    {
      home = "/" + (ldTernary pkgs "home" "Users") + "/" + name;
      shell = pkgs.zsh;
    }
    // (ldTernary pkgs {
      uid = mkDefault 1000;
      isNormalUser = true;
      initialPassword = mkDefault "temp";

      extraGroups = [
        "audio"
        "docker"
        "input"
        "lp"
        "mpd"
        "nix"
        "plugdev"
        "power"
        "systemd-journal"
        "tss"
        "video"
        "wheel"
      ];
    } { })
  );
}
