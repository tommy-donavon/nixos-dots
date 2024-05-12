{ pkgs, lib, config, ... }:

with lib;
let
  aliases = {
    g = "git status";
    ga = "git add .";
    gcm = "git commit -m";
    gco = "git checkout";
    gd = "git diff";
    gl = "git log";
    grs = "git restore";
    gs = "git switch";
    gp = "git pull";
    gP = "git push";
  };
  cfg = config.modules.cli.git;
in
{
  imports = [
    ./ui.nix
  ];
  options.modules.cli.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      git-ignore
    ];

    programs = {
      zsh.shellAliases = aliases;
      git = {
        enable = true;

        userName = "tommy-donavon";
        userEmail = "donavontommy@gmail.com";

        extraConfig = {
          init = { defaultBranch = "main"; };
          push = { autoSetupRemote = true; };
          pull = { rebase = false; };

          url."ssh://git@github.com".insteadOf = "https://github.com/";
        };
      };
    };
  };
}
