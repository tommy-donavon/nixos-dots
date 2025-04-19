{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.nest;
{
  # imports = with inputs; [
  #   home-manager.darwinModules.home-manager
  # ];

  options.nest.home = with types; {
    file = mkOpt attrs { } "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile =
      mkOpt attrs { }
        "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
    homeConfig = mkOpt attrs { } "Final config for home-manager.";
  };

  config = {
    nixdots.home.extraOptions = {
      home.stateVersion = mkDefault "22.11";
      home.file = mkAliasDefinitions options.nest.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.nest.home.configFile;
      # home.sessionPath = [ "$XDG_BIN_HOME" ];
    };

    snowfallorg.users.${config.nest.user.name}.home.config =
      mkAliasDefinitions options.nest.home.extraOptions;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      # users.${config.nest.user.name} = args:
      #   mkAliasDefinitions options.nest.home.extraOptions;
    };
  };
}
