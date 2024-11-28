{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = {
    enable = mkEnableOption "development";
    opsEnable = mkBoolOpt false "Whether or not to enable devops related configuration.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      brews = [
        "bash"
        "gh"
        "git"
        "gmp"
        "jq"
        "libyaml"
        "readline"
        "webkitgtk"
        "yq"
        "openssl@3"
        "llvm"
        "libpq"
        "mysql"
      ];
      casks = [
        "cutter"
        "teleport-connect"
      ];
      taps = [ "pulumi/tap" ];
    };
  };
}
