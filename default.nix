let sources = import ./nix/sources.nix; in

{ pkgs ? import sources.nixpkgs {}
, dapptoolsOverrides ? {}
}:

import pkgs.path {
  overlays = [
    (import ./overlay.nix { inherit dapptoolsOverrides; })
  ];
}
