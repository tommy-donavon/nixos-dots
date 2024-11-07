{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.programs.terminal.tools.tmux;

  configFiles = lib.snowfall.fs.get-files ./config;

  plugins = with pkgs.tmuxPlugins; [
    { plugin = yank; }
    { plugin = tmux-fzf; }
  ];
in
{
  options.${namespace}.programs.terminal.tools.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      aggressiveResize = true;
      baseIndex = 1;
      clock24 = false;
      historyLimit = 2000;
      keyMode = "vi";
      mouse = true;
      newSession = true;
      prefix = "C-Space";
      sensibleOnTop = true;
      terminal = "xterm-256color";
      extraConfig = builtins.concatStringsSep "\n" (builtins.map lib.strings.fileContents configFiles);

      inherit plugins;

    };

    home.shellAliases = {
      t = "tmux";
      tn = "tmux new-session nvim \\; split-window -h \\; split-window -v lazygit \\; attach";
    };
  };
}
