{
    config,
    lib,
    namespace,
    pkgs,
    ...
}:
let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.${namespace}.languages.lua;
in
{
    options.${namespace}.languages.lua = {
        enable = mkEnableOption "lua";
    };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            lua
        ];
    };
}
