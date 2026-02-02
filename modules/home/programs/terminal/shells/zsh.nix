{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    getExe
    getExe'
    ;
  cfg = config.nest.programs.terminal.shells.zsh;
in
{
  options.nest.programs.terminal.shells.zsh = {
    enable = mkEnableOption "zsh" // {
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      dotDir = "${config.xdg.configHome}/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        PROMPT="%F{blue}%m %~%b "$'\n'"%(?.%F{green}%Bλ%b |.%F{red}?) %f"

        export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store";
        export ZK_NOTEBOOK_DIR="~/stuff/notes";
        export DIRENV_LOG_FORMAT="";

        bindkey '^I' complete-word
        bindkey '^[[Z' autosuggest-accept

        bindkey "\e[1;3D" backward-word
        bindkey "\e[1;3C" forward-word
        bindkey "^[[1;9D" beginning-of-line
        bindkey "^[[1;9C" end-of-line

        autoload -Uz compinit && compinit
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        edir() { tar -cz $1 | age -p > $1.tar.gz.age && rm -rf $1 &>/dev/null && echo "$1 encrypted" }
        ddir() { age -d $1 | tar -xz && rm -rf $1 &>/dev/null && echo "$1 decrypted" }

        export PATH="/usr/local/bin:$PATH"
        export PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"

        export DOTS_DIR="$HOME/dots"

      ''
      + lib.optionalString pkgs.stdenv.isDarwin ''
        if [ -f /opt/homebrew/bin/brew ]; then
          	eval "$("/opt/homebrew/bin/brew" shellenv)"
              export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
        fi

        # Nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
         source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
        if [ -f '/nix/var/nix/profiles/default/etc/profile.d/nix.sh' ]; then
         source '/nix/var/nix/profiles/default/etc/profile.d/nix.sh'
        fi
        if [ -e '/run/current-system/sw/bin/darwin-rebuild' ]; then
          export PATH="/run/current-system/sw/bin:$PATH"
        fi
        export PATH="$HOME/.local/state/home-manager/gcroots/current-home/home-path/bin:$PATH"
        # End Nix
      ''
      + ''
        eval "$(starship init zsh)"
        eval "$(direnv hook zsh)"
      '';

      history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
      };

      shellAliases = {
        c = "clear";
        mkdir = "mkdir -vp";
        rm = "rm -rif";
        mv = "mv -iv";
        cp = "cp -riv";
        nd = "nix develop -c $SHELL";

        # Navigation shortcuts
        home = "cd ~";
        dots = "cd $DOTS_DIR";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";

        # Colorize output
        dir = "${getExe' pkgs.coreutils "dir"} --color=auto";
        egrep = "${getExe' pkgs.gnugrep "egrep"} --color=auto";
        fgrep = "${getExe' pkgs.gnugrep "fgrep"} --color=auto";
        grep = "${getExe pkgs.gnugrep} --color=auto";
        vdir = "${getExe' pkgs.coreutils "vdir"} --color=auto";

        # Misc
        clr = "clear";
        pls = "sudo";
        usage = "${getExe' pkgs.coreutils "du"} -ah -d1 | sort -rn 2>/dev/null";
      };

    };
  };
}
