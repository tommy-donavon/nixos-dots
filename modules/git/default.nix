{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
    options.modules.git = { enable = mkEnableOption "git"; };
    config = mkIf cfg.enable {
        programs.git = {
            enable = true;
            userName = "tommy-donavon";
            userEmail = "donavontommy@gmail.com";
            extraConfig = {
                init = { defaultBranch = "main"; };
                push = { autoSetupRemote = true; };
                url."ssh://git@github.com".insteadOf = "https://github.com/";
            };
        };
    };
}
