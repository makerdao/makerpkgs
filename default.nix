{
  pkgsSrc ? fetchTarball {
    name = "nixpkgs-18.09";
    # pin the current release-18.09 commit taken from dapptools
    url = "https://github.com/nixos/nixpkgs/archive/185ab27b8a2ff2c7188bc29d056e46b25dd56218.tar.gz";
    sha256 = "0bflmi7w3gas9q8wwwwbnz79nkdmiv2c1bpfc3xyplwy8npayxh2";
  },
  dappSrcOverrides ? {}
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

  getDappPkgsSrc = { rev, ref ? "" }: fetchGit {
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

  dappPkgsSrcs = rec {
    # Use HEVM 0.28 for running tests, because there seems to be a bug that
    # fails some tests incorrectly.
    current = dapp_hevm-0_28;

    latest = getDappPkgsSrc {
      rev = "41029f1ed325aaad71463f9ad4b43d176778dca7";
      ref = "master";
    };

    dapp-0_16_0 = getDappPkgsSrc {
      rev = "6943c76bfb8e0b1fce54c3d9bba6f0f7e50d2f5c";
      ref = "dapp/0.16.0";
    };

    dapp-0_18_0 = getDappPkgsSrc {
      rev = "deb8b07972a28c4753c82215ed0c0c5b94cb8e31";
      ref = "dapp/0.18.0";
    };

    dapp-0_18_1 = getDappPkgsSrc {
      rev = "7207c0a92f0aaa19b60c84c14c1ed078892b0436";
      ref = "dapp/0.18.1";
    };

    dapp-0_19_0 = getDappPkgsSrc {
      rev = "10388fb8083e9b3aff53a48afb65c746ade7093b";
      ref = "master";
    };

    dapp_hevm-0_28 = getDappPkgsSrc {
      rev = "214632b08a39872d50ceb3a726b0ca2d70d19e06";
      ref = "master";
    };
  } // dappSrcOverrides;

  pkgsVersions = mapAttrs (_: mkPkgs {}) dappPkgsSrcs;

  pkgs = mkPkgs {
    extraOverlays = [
      (self: super: rec {
        # Packages overrides

        # Use `solidityPackage` expression from >dapp/0.18.1 becuase missing
        # features not yet in tagged version of dapptools.
        inherit (pkgsVersions.latest) solidityPackage;
      })
    ];
  } dappPkgsSrcs.current;
}
