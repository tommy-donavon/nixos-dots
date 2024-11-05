{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "wofi-bluetooth";

  src = pkgs.fetchFromGitHub {
    owner = "arpn";
    repo = "wofi-bluetooth";
    rev = "722dc554c7a9515bca1cc646d226f65883f9343f";
    sha256 = "0y2apgqiwkr0hdrqiglnfwa49dx8gm9d4gvmik45075a63qn1il3";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp wofi-bluetooth $out/bin/wofi-bluetooth
    chmod +x $out/bin/wofi-bluetooth
  '';
}
