{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nest.programs.terminal.tools.k8s;
in
{
  options.nest.programs.terminal.tools.k8s = {
    enable = mkEnableOption "k8s";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      helmfile
      kubecolor
      kubectl
      kubectx
      kubelogin
      kubernetes-helm
      kubeseal
    ];

    programs = {
      k9s = {
        enable = true;
        settings.k9s = {
          liveViewAutoRefresh = true;
          refreshRate = 1;
          maxConnRetry = 3;
          ui = {
            enableMouse = true;
          };
        };
      };
    };

    home.shellAliases = {
      k = "kubecolor";
      kc = "kubectx";
      kn = "kubens";
      ks = "kubeseal";
      kubectl = "kubecolor";
    };
  };

}
