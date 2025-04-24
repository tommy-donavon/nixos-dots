{
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (self.lib.module) mkOpt enabled;

  cfg = config.nest.services.nix-daemon;
in
{
  options.nest.services.nix-daemon = {
    enable = mkOpt types.bool true "Whether to enable the Nix daemon";
  };

  config = mkIf cfg.enable { services.nix-daemon = enabled; };
}
