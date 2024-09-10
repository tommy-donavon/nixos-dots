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
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # onefetch
      chafa
    ];
    # home = {
    #   packages =
    #     with pkgs;
    #     [
    #       jqp
    #       neovide
    #       onefetch
    #       postman
    #     ]
    #     ++ lib.optionals pkgs.stdenv.isLinux [
    #       qtcreator
    #     ]
    #     ++ lib.optionals cfg.nixEnable [
    #       nixpkgs-hammering
    #       nixpkgs-lint-community
    #       nixpkgs-review
    #       nix-update
    #     ]
    #     ++ lib.optionals cfg.gameEnable [
    #       godot_4
    #       # NOTE: removed from nixpkgs
    #       # ue4
    #       unityhub
    #     ]
    #     ++ lib.optionals cfg.sqlEnable [
    #       dbeaver-bin
    #       mysql-workbench
    #     ];

    #   shellAliases = {
    #     prefetch-sri = "nix store prefetch-file $1";
    #   };
    # };

    programs.home-manager.enable = true;

    nixdots = {
      languages = {
        rust.enable = true;
      };
      programs = {
        # graphical = {
        #   editors = {
        #     vscode = enabled;
        #   };
        # };

        terminal = {
          editors = {
            nvim.enable = true;
          };
          shells = {
            zsh.enable = true;
          };

          tools = {
            # git-crypt = enabled;
            # go.enable = cfg.goEnable;
            # k9s.enable = cfg.kubernetesEnable;
            # lazydocker.enable = cfg.dockerEnable;
            lazygit.enable = true;
            starship.enable = true;
            xplr.enable = true;
          };
        };
      };
    };
  };
}
