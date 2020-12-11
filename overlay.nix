{ dapptoolsOverrides ? {} }:

self: super: with super;

let
  inherit (lib) mapAttrs;
  sources = import ./nix/sources.nix;

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
      dapp ethsign seth solc hevm solc-versions solc-static-versions go-ethereum-unlimited evmdis
      dapp2
      solidityPackage
      ;

    setzer-mcd = self.callPackage sources.setzer-mcd {};

    sethret = (import sources.sethret { inherit pkgs; }).sethret;

    dapp2nix = import sources.dapp2nix { inherit pkgs; };

    abi-to-dhall = import sources.abi-to-dhall { inherit pkgs; };

    makerCommonScriptBins = with self; [
      coreutils gnugrep gnused findutils
      bc jq
      solc
      dapp ethsign seth
    ];

    makerScriptPackage = self.callPackage ./script-builder.nix {};
  };
in (makerpkgs { inherit dapptoolsOverrides; }) // {
  makerpkgs = makeOverridable makerpkgs { inherit dapptoolsOverrides; };
}
