{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkAfter;

  cfg = config.nest.programs.terminal.tools.tmux;
in
{
  options.nest.programs.terminal.tools.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ fzf ];
    programs = {
      zsh = {
        initContent = mkAfter ''
          function tmux_session() {
            name="''${1:-$(basename $PWD)}"
            tmux new-session -s ''${name}
          }

          function tmux_start() {
            spath=''${1:-$PWD}
            tmux new-session -s "$(basename $spath)" -c "$(realpath $spath)"
          }

          function tmux_attach() {
            if [[ -n "$1" ]]; then
              tmux attach -t "$1"
            else
              tmux attach
            fi
          }

          function tmux_fzf_sessions() {
            name=$(tmux ls -F "#S" | fzf)
            [[ -z "$name" ]] || tmux_attach "$name";
          }
        '';
        shellAliases = {
          tms = "tmux_session";
          tmsa = "tmux_start";
          tml = "tmux list-sessions";
          tma = "tmux_attach";
          tmat = "tmux attach -t";

          tmla = "tmux_fzf_sessions";
        };
      };
      tmux = {
        enable = true;

        prefix = "C-a";
        keyMode = "emacs";
        reverseSplit = true;
        mouse = true;
        shell = "${pkgs.zsh}/bin/zsh";
        sensibleOnTop = false;

        plugins = [
          {
            plugin = pkgs.tmuxPlugins.tmux-fzf;
            extraConfig = ''
              TMUX_FZF_LAUNCH_KEY="space"
            '';
          }
        ];
      };
    };

  };
}
