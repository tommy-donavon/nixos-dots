{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [ "adobe-reader-9.5.5" ];
  };
}
