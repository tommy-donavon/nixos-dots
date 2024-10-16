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
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        # onefetch
        chafa
      ]
      ++ lib.optionals cfg.opsEnable [ tenv ];

    programs.home-manager = enabled;

    nixdots = {
      languages = {
        rust = enabled;
      };
      
      programs = {

        terminal = {
          editors = {
            nvim = enabled;
          };
          emulators = {
            alacritty = enabled;
            foot = enabled;
          };
          shells = {
            zsh = enabled;
          };

          tools = {
            # git-crypt = enabled;
            # go = cfg.goEnable;
            k8s.enable = cfg.opsEnable;
            # lazydocker = cfg.dockerEnable;
            lazygit = enabled;
            git = enabled;
            starship = enabled;
            xplr = enabled;
            direnv = enabled;
            ripgrep = enabled;
          };
        };
      };
      system.xdg = enabled;
    };
  };
}
