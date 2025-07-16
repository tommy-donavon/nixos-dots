{ inputs, ... }:
{
  nixpkgs.overlays =
    with inputs;
    [
      nur.overlays.default
    ]
    ++ [
      (_: prev: {
        unstable = import inputs.unstable {
          inherit (prev) system;
        };
      })
    ];
}
