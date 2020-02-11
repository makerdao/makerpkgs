let srcs = import ./srcs.nix; in

{ pkgs ? import srcs.nixpkgs {}
, dapptoolsOverrides ? {}
}:

import pkgs.path {
  overlays = [
    (import ./overlay.nix { inherit dapptoolsOverrides; })
  ];
}
