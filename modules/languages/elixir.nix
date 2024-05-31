{config, lib, pkgs, ...}:

with lib;
let
  cfg = config.modules.langs.elixir;
in
{
  options.modules.langs.elixir = {enable = mkEnableOption "elixir"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs.beam.packages; [
      erlang.elixir
      # asdf-vm
      # elixir_1_16
      # erlang_26
    ];
  };
}
