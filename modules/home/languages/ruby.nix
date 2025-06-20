{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.nest.languages.ruby;
in
{
  options.nest.languages.ruby = {
    enable = mkEnableOption "ruby";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rbenv ];

    programs.rbenv = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.rbenv;

      plugins = [
        {
          name = "ruby-build";
          src = pkgs.fetchFromGitHub {
            owner = "rbenv";
            repo = "ruby-build";
            rev = "v20250215";
            hash = "sha256-muVto9QYC9kYVrjt1NhDg+RZ6xcrNLkuoqFLZlOvmM4=";
          };
        }
      ];
    };
  };
}
