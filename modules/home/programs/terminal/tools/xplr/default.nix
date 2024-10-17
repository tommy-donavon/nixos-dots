{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.programs.terminal.tools.xplr;
in
{
  options.${namespace}.programs.terminal.tools.xplr = {
    enable = mkEnableOption "xplr";
  };

  config = mkIf cfg.enable {
    programs.xplr = {
      enable = true;
      plugins = {
        tree-view = pkgs.fetchFromGitHub {
          owner = "sayanarijit";
          repo = "tree-view.xplr";
          sha256 = "11chpxvqw967wq579bj8l62l8gs37ybylmxf75z735xrk2x87lmz";
          rev = "eeba82a862ca296db253d7319caf730ce1f034c2";
        };
        web-devicons = pkgs.fetchFromGitLab {
          owner = "hartan";
          repo = "web-devicons.xplr";
          sha256 = "1csypn5cp21vpplpjzhgqcsgc1ahlrazb4kmlg0w463isjh34va1";
          rev = "b54187954f0a2639c2e355f8f0970d5692357eb0";
        };
      };
      extraConfig = ''
        require("tree-view").setup()
        require("web-devicons").setup()
      '';
    };

    home.shellAliases = {
      x = "xplr";
    };
  };
}
