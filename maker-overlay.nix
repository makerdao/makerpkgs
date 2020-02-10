{ dapptoolsOverrides }:

self: super: with super;

let
  inherit (builtins) mapAttrs;
  srcs = import ./srcs.nix;
in rec {
  dapptoolsVersions = callPackage
    ./dapptools-overlay.nix
    { inherit dapptoolsOverrides; };

  dappPkgsVersions = mapAttrs
    (_: dappPkgsSrc: import dappPkgsSrc {})
    dapptoolsVersions;

  dappPkgs = dappPkgsVersions.current;

  inherit (dappPkgs) dapp ethsign seth solc;

  # Add mcd-cli and sethret to local scope
  mcd-cli = callPackage srcs.mcd-cli {};

  sethret = (import srcs.sethret { inherit pkgs; }).sethret;

  dapp2nix = import srcs.dapp2nix { inherit pkgs; };

  abi-to-dhall = import srcs.abi-to-dhall { inherit pkgs; };

  makerCommonScriptBins = with self; [
    coreutils gnugrep gnused findutils
    bc jq
    solc
    dapp ethsign seth mcd-cli
  ];

  makerScriptPackage = self.callPackage ./script-builder.nix {};
}
