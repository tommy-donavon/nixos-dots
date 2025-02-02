{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    types
    ;

  inherit (lib.${namespace}) mkOpt;
  cfg = config.${namespace}.services.greetd;
in
{
  options.${namespace}.services.greetd = with types; {
    enable = mkEnableOption "greetd";
    command = mkOpt str "Hyprland" "Command to execute on login";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.greetd; [
      tuigreet
    ];
    services.greetd = {
      enable = true;
      vt = 2;
      settings = rec {
        initial_session = {
          inherit (cfg) command;
          user = config.${namespace}.user.name;
        };
        default_session = initial_session;
      };
    };
  };
}
