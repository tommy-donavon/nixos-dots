{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.programs.terminal.tools.git;
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

		extraConfig = {
		  init = { defaultBranch = "main"; };
          push = { autoSetupRemote = true; };
          pull = { rebase = false; };

          #url."ssh://git@github.com".insteadOf = "https://github.com/";
		};
	};
  };
}
