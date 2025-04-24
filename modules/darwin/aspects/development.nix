{
  config,
  lib,
  self,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (self.lib.module) mkBoolOpt;

  cfg = config.nest.aspects.development;
in
{
  options.nest.aspects.development = {
    enable = mkEnableOption "development";
    opsEnable = mkBoolOpt false "Whether or not to enable devops related configuration.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      brews = [
        "bash"
        "gh"
        "gmp"
        "jq"
        "libyaml"
        "readline"
        "yq"
        "openssl@3"
        "llvm"
        "libpq"
        "mysql@8.0"
      ];
      casks = [
        "cutter"
        "ghostty"
      ];
      taps = mkIf cfg.opsEnable [ "pulumi/tap" ];
    };
  };
}
