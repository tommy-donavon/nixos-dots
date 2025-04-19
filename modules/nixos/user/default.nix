{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.nest) mkOpt;

  cfg = config.nest.user;
in
{
  options.nest.user = with types; {
    email = mkOpt str "donavontommy@gmail.com" "The email of the user.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to <option>users.users.<name></option>.";
    fullName = mkOpt str "Tommy Donavon" "The full name of the user.";
    initialPassword =
      mkOpt str "password"
        "The initial password to use when the user is first created.";
    name = mkOpt str "tommy" "The name to use for the user account.";
  };

  config = {
    environment.systemPackages = with pkgs; [
      fortune
      lolcat
    ];

    environment.pathsToLink = [ "/share/zsh" ];

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CACHE_HOME/zsh.history";
    };

    users.users.${cfg.name} = {
      inherit (cfg) name initialPassword;

      extraGroups = [
        "wheel"
        "systemd-journal"
        "mpd"
        "audio"
        "video"
        "input"
        "plugdev"
        "lp"
        "tss"
        "power"
        "nix"
        "docker"
      ] ++ cfg.extraGroups;

      group = "users";
      home = "/home/${cfg.name}";
      isNormalUser = true;
      shell = pkgs.zsh;
      uid = 1000;
    } // cfg.extraOptions;
  };
}
