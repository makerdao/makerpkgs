source $stdenv/setup
unpackPhase

find . -maxdepth 2 -type f -perm /111 ! -name "*.sh" | while read -r script; do
  dest=$out/bin/''${script#./}
  mkdir -p ''${dest%/*}

  perl -pe '\
    s|^(cd (?:.*/)*([^/\n\r]+))$|\1;export DAPP_OUT=\$DAPP_LIB/\2/out;|;
    s|^dapp .*build||;
  ' < $script > $dest
  chmod +x $dest

  wrapProgram $dest \
    --set PATH "${lib.makeBinPath baseBins}" \
    --set DAPP_SKIP_BUILD yes \
    --set DAPP_LIB ${depsMerged}/dapp
done

find . -maxdepth 2 -type f -name "*.json" | while read -r config; do
  dest=$out/bin/''${config#./}
  mkdir -p ''${dest%/*}
  cp -v $config $dest
done

cp -rv lib $out/bin/lib

patchPhase

checkPhase

mkdir -p $out/dapp/$name
cp -r $src $out/dapp/$name/src
cp -r lib $out/dapp/$name/lib
cp -r out $out/dapp/$name/out
