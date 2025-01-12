{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.programs.terminal.tools.git;

  git = "${pkgs.git}/bin/git";
  awk = "${pkgs.gawk}/bin/awk";
  xargs = "${pkgs.findutils}/bin/xargs";
in
{
  options.${namespace}.programs.terminal.tools.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "tommy-donavon";
      userEmail = "donavontommy@gmail.com";
      delta = enabled;

      aliases = {
        gone = ''
          !${git} fetch -p && ${git} for-each-ref --format='%(refname:short) %(upstream:track)' | \
          ${awk} '$2 == "[gone]" {print $1}' | \
          ${xargs} -r ${git} branch -D
        '';
      };

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
        pull = {
          rebase = false;
        };

      };
    };
  };
}
