{
  config,
  lib,
  self,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  git = "${pkgs.git}/bin/git";
  awk = "${pkgs.gawk}/bin/awk";
  xargs = "${pkgs.findutils}/bin/xargs";

  cfg = config.nest.programs.terminal.tools.git;
in
{
  options.nest.programs.terminal.tools.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "tommy-donavon";
          email = "donavontommy@gmail.com";
        };

        aliases = {
          gone = ''
            !${git} fetch -p && ${git} for-each-ref --format='%(refname:short) %(upstream:track)' | \
            ${awk} '$2 == "[gone]" {print $1}' | \
            ${xargs} -r ${git} branch -D
          '';
        };
        extraConfig = {
          column = {
            ui = "auto";
          };
          branch = {
            sort = "-committerdate";
          };
          tag = {
            sort = "version:refname";
          };
          diff = {
            algorithm = "histogram";
            coloreMoved = "plain";
            mnemonicPrefix = true;
            renames = true;
          };
          init = {
            defaultBranch = "main";
          };
          push = {
            default = "simple";
            autoSetupRemote = true;
            followTags = true;
          };
          fetch = {
            prune = true;
            pruneTags = true;
            all = true;
          };
          help = {
            autocorrect = "prompt";
          };
          rerere = {
            enabled = true;
            autoupdate = true;
          };
          core = {
            excludesfile = "~/.gitignore";
          };
          rebase = {
            autoSquash = true;
            autoStash = true;
            updateRefs = true;
          };
          commit = {
            verbose = true;
          };
          pull = {
            rebase = true;
          };

        };
      };

    };
  };
}
