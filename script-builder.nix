{ lib, stdenv, symlinkJoin, writeScriptBin, makeWrapper
, perl, shellcheck
, makerCommonScriptBins
}:

let
  inherit (builtins) attrNames attrValues elemAt length;

  overrideOverrideAttrs = f: attrs: (f attrs) // {
    overrideAttrs = f_: overrideOverrideAttrs f (attrs // (f_ attrs));
  };
in

overrideOverrideAttrs (
{ name
, solidityPackages ? []
, extraBins ? []
, scriptEnv ? {}
, passthru ? {}
, ... } @ args:

let
  bins = makerCommonScriptBins ++ extraBins;

  # Symlink all solidity packages into one directory
  depsMerged = symlinkJoin {
    name = "${name}-solidity-packages";
    paths = solidityPackages;
  };

  scriptEnv' = (lib.optionalAttrs ((length solidityPackages) == 1)
    (let
      singleDep = elemAt solidityPackages 0;
    in {
      DAPP_OUT = "${depsMerged}/dapp/${singleDep.name}/out";
    })) // scriptEnv;

in stdenv.mkDerivation ({
  src = lib.cleanSource (lib.sourceByRegex ./. [ "[^/]*" "(bin|lib|libexec|scripts|config)/.*" ]);
  buildInputs = [ makeWrapper ];
  buildPhase = "true";

  BIN_PATH = lib.makeBinPath bins;
  DAPP_LIB = "${depsMerged}/dapp";
  SCRIPT_ENV = lib.concatStringsSep " " (map
    (name: "--set ${name} ${toString scriptEnv'."${name}"}")
    (attrNames scriptEnv')
  );

  installPhase = ''
    binDir=$out/bin
    libDir=$out/lib
    libexecDir=$out/libexec
    configDir=$out/share/config

    patchBin_() {
      if [ "$patchBin" ]; then $patchBin; else cat; fi
    }

    patchDappLib() {
      ${perl}/bin/perl -pe '
        s|^dapp .*\bbuild||;
        s|^dapp .*\bupdate||;
      '
    }

    wrapScript() {
      patchBin_ | patchDappLib > $1
      chmod +x $1

      wrapProgram $1 \
        --set BIN_DIR $binDir \
        --set LIB_DIR $libDir \
        --set LIBEXEC_DIR $libexecDir \
        --set CONFIG_DIR $configDir \
        --set PATH "$BIN_PATH" \
        --set DAPP_LIB "$DAPP_LIB" \
        --set DAPP_SKIP_BUILD yes \
        $SCRIPT_ENV
    }

    find . -type f -perm /111 -regextype sed -regex '\./\([^/]*\|bin/.*\)' \
    | while read -r script; do
      dest=$binDir/''${script##*/}
      mkdir -p ''${dest%/*}
      wrapScript $dest < $script
    done

    find . -type f -perm /111 -regextype sed -regex '\./\(libexec\|scripts\)/.*' \
    | while read -r script; do
      dest=$libexecDir/''${script#./*/}
      mkdir -p ''${dest%/*}
      wrapScript $dest < $script
    done

    find . -type f -regextype sed -regex '\./lib/.*' \
    | while read -r script; do
      dest=$libDir/''${script#./*/}
      mkdir -p ''${dest%/*}
      cp -v $script $dest
      chmod -x $dest
    done

    find . -type f -regextype sed -regex '\./\([^/]*\.json\|config/.*\)' \
    | while read -r config; do
      dest=$configDir/''${config##*/}
      mkdir -p ''${dest%/*}
      cp -v $config $dest
    done
  '';

  checkPhase = ''
    ${shellcheck}/bin/shellcheck $out/bin/* $out/libexec/* $out/lib/*
  '';

  passthru = {
    inherit solidityPackages bins;
  } // passthru;
} // (removeAttrs args [ "solidityPackages" "extraBins" "scriptEnv" "passthru" ])))
