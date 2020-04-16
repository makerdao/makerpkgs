{ dapptoolsOverrides ? {} }:

self: super: with super;

let
  inherit (lib) mapAttrs;
  srcs = import ./srcs.nix;

  dappSources = callPackage
    ./dapptools-overlay.nix
    { inherit dapptoolsOverrides; };

  dappPkgsVersions = mapAttrs
    (_: dappPkgsSrc: import dappPkgsSrc {})
    dappSources;

  makerpkgs = { dapptoolsOverrides ? {} }: rec {
    inherit dappSources dappPkgsVersions;

    dappPkgs = if dappPkgsVersions ? current
      then dappPkgsVersions.current
      else dappPkgsVersions.default
      ;

    # Inherit derivations from dapptools
    inherit (dappPkgs)
      dapp ethsign seth solc hevm solc-versions go-ethereum-unlimited evmdis
      mcd dai setzer dapp2
      solidityPackage
      ;

    setzer-mcd = self.callPackage srcs.setzer-mcd {};

    sethret = (import srcs.sethret { inherit pkgs; }).sethret;

    dapp2nix = import srcs.dapp2nix { inherit pkgs; };

    abi-to-dhall = import srcs.abi-to-dhall { inherit pkgs; };

    makerCommonScriptBins = with self; [
      coreutils gnugrep gnused findutils
      bc jq
      solc
      dapp ethsign seth mcd
    ];

    makerScriptPackage = self.callPackage ./script-builder.nix {};
  };
in (makerpkgs { inherit dapptoolsOverrides; }) // {
  makerpkgs = makeOverridable makerpkgs { inherit dapptoolsOverrides; };
}
