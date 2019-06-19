self: super: with super;

{
  # Add mcd-cli and sethret to local scope
  mcd-cli = callPackage (import (fetchGit {
    url = https://github.com/makerdao/mcd-cli.git;
    rev = "86842b49defa53301ac0019f7d5994859bb3e1e9";
  })) {};

  sethret = (import (fetchGit {
    url = https://github.com/icetan/sethret.git;
    rev = "ef77915e2881011603491275f36b44bf2478b408";
  }) { inherit pkgs; }).sethret;

  dapp2nix = import (fetchGit {
    url = https://github.com/icetan/dapp2nix.git;
    rev = "4b92b341fc0a094bdbd660bc08a4e42a1c8cfd62";
    ref = "v1.1.0";
  }) { inherit pkgs; };

  makerCommonScriptBins = with self; [
    coreutils gnugrep gnused findutils
    bc jq
    solc
    dapp ethsign seth mcd-cli
  ];

  makerScriptPackage = self.callPackage ./script-builder.nix { };
}
