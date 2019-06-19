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

  mkPkgs = { extraOverlays ? [] }: dappPkgsSrc:
    import pkgsSrc {
      overlays = [
        (import "${dappPkgsSrc}/overlay.nix")
        (import ./maker-overlay.nix)
      ] ++ extraOverlays;
    };

  dapptoolsVersions = import ./dapptools-overlay.nix { inherit dapptoolsOverrides; };
  pkgsVersions = mapAttrs (_: mkPkgs {}) dapptoolsVersions;

  pkgs = pkgsVersions.current;
}
