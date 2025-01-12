{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = {
    enable = mkBoolOpt false "Whether or not to enable common development configuration.";
    opsEnable = mkBoolOpt false "Whether or not to enable devops related configuration.";
    dataEnable = mkBoolOpt false "Whether or not to enable database related configuration";
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        chafa
        libgccjit
        pkg-config
        gcc
        openssl
        postman
      ]
      ++ lib.optionals cfg.opsEnable [
        argocd
        tenv
        kind
        teleport_15
      ]
      ++ lib.optionals cfg.dataEnable [
        dbeaver-bin
        pgadmin4
        redisinsight
      ];

    programs.home-manager = enabled;

    nixdots = {
      languages = {
        rust = enabled;
        lua = enabled;
        node = enabled;
      };

      programs = {
        terminal = {
          editors = {
            nvim = enabled;
          };
          emulators = {
            alacritty = enabled;
            foot = mkIf pkgs.stdenv.isLinux enabled;
            ghostty = enabled;
          };
          shells = {
            zsh = enabled;
          };

          tools = {
            direnv = enabled;
            git = enabled;
            k8s.enable = cfg.opsEnable;
            lazygit = enabled;
            ripgrep = enabled;
            starship = enabled;
            tmux = enabled;
            xplr = enabled;
          };
        };
      };
    };
  };
}
