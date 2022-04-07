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

  dappPkgs = if dappPkgsVersions ? current
    then dappPkgsVersions.current
    else dappPkgsVersions.default
    ;

  solc-static-versions = mapAttrs (n: v: runCommand "solc-${v.version}-static" {} ''
    mkdir -p $out/bin
    ln -s ${v}/bin/solc* $out/bin/solc
  '') dappPkgs.solc-static-versions;

  makerpkgs = { dapptoolsOverrides ? {} }: rec {
    inherit dappSources dappPkgsVersions dappPkgs solc-static-versions;

    # Inherit derivations from dapptools
    inherit (dappPkgs)
      dapp ethsign seth solc hevm solc-versions go-ethereum-unlimited evmdis
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
