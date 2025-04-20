# tools commonly used in development
{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib.module) mkBoolOpt enabled;

  cfg = config.nest.aspects.development;
in
{
  options.nest.aspects.development = {
    enable = mkBoolOpt false "Whether or not to enable common development configuration.";
    opsEnable = mkBoolOpt false "Whether or not to enable devops related configuration.";
    dataEnable = mkBoolOpt false "Whether or not to enable database related configuration";
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        atac
        gcc
        grex
        libgccjit
        openssl
        pkg-config
        postman
        charm-freeze
        typos-lsp
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
        rainfrog
        redisinsight
      ];

    nest = {
      programs = {
        terminal = {
          tools = {
            # direnv = enabled;
            k8s.enable = cfg.opsEnable;
            lazygit = enabled;
            starship = enabled;
            tealdeer = enabled;
          };
        };
      };
    };
  };
}
