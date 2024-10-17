{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.languages.rust;
in
{
  options.${namespace}.languages.rust = {
    enable = mkEnableOption "rust";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ rust-bin.stable.latest.default ]; };
}
