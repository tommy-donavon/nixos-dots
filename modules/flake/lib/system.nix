{ pkgs }:
let
  inherit (builtins) throw;
  systemTernary =
    pkgs: l: d:
    if pkgs.stdenv.hostPlatform.isLinux then
      l
    else if pkgs.stenv.hostPlatform.isDarwin then
      d
    else
      throw "unsupported system: ${pkgs.stdenv.system}";
in
{
  inherit systemTernary;
}
