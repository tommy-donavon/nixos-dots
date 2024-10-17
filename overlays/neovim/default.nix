{ channels, inputs, ... }:

final: prev: {
  inherit (channels.unstable) neovim;

}
