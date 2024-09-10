{  
  lib,
  namespace, 
  pkgs,
  config,
  ...}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.editors.nvim;
in {
  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  options.${namespace}.programs.terminal.editors.nvim = { 
  enable = mkBoolOpt false "nvim"; 
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim-unwrapped
    ];
  };
}
