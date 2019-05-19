{
  pkgsSrc ? fetchTarball {
    name = "nixpkgs-18.09";
    # pin the current release-18.09 commit taken from dapptools
    url = "https://github.com/nixos/nixpkgs/archive/185ab27b8a2ff2c7188bc29d056e46b25dd56218.tar.gz";
    sha256 = "0bflmi7w3gas9q8wwwwbnz79nkdmiv2c1bpfc3xyplwy8npayxh2";
  },
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

  dappPkgsSrcs = {
    latest = getDappPkgsSrc {
      rev = "af5953f004fe1edfb41dcc4a90a5340191078ce1";
      ref = "master";
    };

    dapp-0_16_0 = getDappPkgsSrc {
      rev = "6943c76bfb8e0b1fce54c3d9bba6f0f7e50d2f5c";
      ref = "dapp/0.16.0";
    };
  };

  pkgsVersions = mapAttrs (_: mkPkgs {}) dappPkgsSrcs;

  pkgs = mkPkgs {
    extraOverlays = [
      (self: super: {
        # Use HEVM from dapp/0.16.0 instead of latest for running tests
        inherit (pkgsVersions.dapp-0_16_0) dapp2;
      })
    ];
  } dappPkgsSrcs.latest;
}
