{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (self.lib.system) systemTernary;

  darwinCommand = pkgs.runCommand "dummy-ghostty" {
    meta = {
      mainProgram = "dummy-ghostty";
    };
  } "mkdir -p $out";

  cfg = config.nest.programs.terminal.emulators.ghostty;
in
{
  options.nest.programs.terminal.emulators.ghostty = {
    enable = mkEnableOption "ghostty";
  };
  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      # ghostty is broken on darwin currently so the package
      # installation needs to come from a different source
      # see https://github.com/tommy-donavon/nixos-dots/blob/main/modules/darwin/aspects/development.nix#L36
      package = systemTernary pkgs pkgs.ghostty darwinCommand;

      installVimSyntax = true;
      installBatSyntax = false;
      settings = {
        window-decoration = toString pkgs.stdenv.hostPlatform.isDarwin;
      };
    };

  };
}
