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
    rev = "bff040c2bc8d4cb862c47bb3d6f6e74a9c9d83b2";
  }) { inherit pkgs; };

  makerScriptPackage = self.callPackage ./script-builder.nix {};
}
