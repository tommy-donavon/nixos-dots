{ inputs, ... }:
{
  nixpkgs.overlays =
    with inputs;
    [
      nur.overlays.default
      hyprpanel.overlay
    ]
    ++ [
      (_: prev: {
        unstable = import inputs.unstable {
          inherit (prev) system;
        };
      })
    ];
}
