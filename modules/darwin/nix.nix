{
  nix = {
    gc.interval = {
      Hour = 3;
      Minute = 15;
    };

    linux-builder = {
      enable = true;
      ephemeral = false;
      maxJobs = 4;
      config = {
        virtualisation.cores = 4;
        virtualisation.darwin-builder.memorySize = 8 * 1024;
      };
    };

    settings.trusted-users = [ "@admin" ];
  };
}
