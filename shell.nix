let sources = import ./nix/sources.nix; in

{ pkgs ? import sources.nixpkgs {}
, niv ? import sources.niv {}
}:

pkgs.mkShell {
  buildInputs = [ niv.niv ];
  shellHook = ''
    echo '
  Use `niv` to manage dependencies:

  $ niv show

  To update a dependency like `nixpkgs`:

  $ niv update nixpkgs
'
  '';
}
