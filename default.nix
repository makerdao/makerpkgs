{
  pkgsSrc ? fetchTarball {
    name = "nixpkgs-19.03";
    # pin the current release-18.09 commit taken from dapptools
    url = "https://github.com/nixos/nixpkgs/archive/f1707d8875276cfa110139435a7e8998b4c2a4fd.tar.gz";
    sha256 = "14p7qvn3z58asx5naa2l5hvp1fddi186h385f7cj2ciw4pknrj9m";
  },
  dapptoolsOverrides ? {}
}:

let
  inherit (builtins) map listToAttrs attrNames;
  mapAttrs = if (builtins ? mapAttrs)
    then builtins.mapAttrs
    else f: attrs:
      listToAttrs (map
        (name: { inherit name; value = f name attrs."${name}"; })
        (attrNames attrs));
in rec {
  inherit pkgsSrc;

  fetchDapptoolsVersion = { rev, ref ? "" }: fetchGit {
    inherit rev ref;
    url = "https://github.com/dapphub/dapptools";
  };

  mkPkgs = { extraOverlays ? [] }: dappPkgsSrc:
    import pkgsSrc {
      overlays = [
        (import "${dappPkgsSrc}/overlay.nix")
        (import ./maker.nix)
      ] ++ extraOverlays;
    };

  dapptoolsVersions = rec {
    # Use HEVM 0.28 for running tests, because there seems to be a bug that
    # fails some tests incorrectly.
    current = hevm-0_28;

    latest = fetchDapptoolsVersion {
      rev = "41029f1ed325aaad71463f9ad4b43d176778dca7";
      ref = "master";
    };

    dapp-0_16_0 = fetchDapptoolsVersion {
      rev = "6943c76bfb8e0b1fce54c3d9bba6f0f7e50d2f5c";
      ref = "dapp/0.16.0";
    };

    dapp-0_18_0 = fetchDapptoolsVersion {
      rev = "deb8b07972a28c4753c82215ed0c0c5b94cb8e31";
      ref = "dapp/0.18.0";
    };

    dapp-0_18_1 = fetchDapptoolsVersion {
      rev = "7207c0a92f0aaa19b60c84c14c1ed078892b0436";
      ref = "dapp/0.18.1";
    };

    dapp-0_19_0 = fetchDapptoolsVersion {
      rev = "10388fb8083e9b3aff53a48afb65c746ade7093b";
      ref = "master";
    };

    hevm-0_28 = fetchDapptoolsVersion {
      rev = "214632b08a39872d50ceb3a726b0ca2d70d19e06";
      ref = "master";
    };
  } // dapptoolsOverrides;

  pkgsVersions = mapAttrs (_: mkPkgs {}) dapptoolsVersions;

  pkgs = mkPkgs {
    extraOverlays = [
      (self: super: rec {
        # Packages overrides

        # Use `solidityPackage` expression from >dapp/0.18.1 becuase missing
        # features not yet in tagged version of dapptools.
        inherit (pkgsVersions.latest) solidityPackage;
      })
    ];
  } dapptoolsVersions.current;
}
