{
  nixpkgs = fetchGit {
    url = "https://github.com/nixos/nixpkgs-channels";
    rev = "ea553d8c67c6a718448da50826ff5b6916dc9c59";
    ref = "nixos-19.09";
  };

  setzer-mcd = fetchGit {
    url = "https://github.com/makerdao/setzer-mcd";
    rev = "ba3cc5768d4d289ea3ddea3c9b3b77d8e931ea4b";
    ref = "master";
  };

  sethret = fetchGit {
    url = https://github.com/icetan/sethret.git;
    rev = "b3cb07f64a5e05041cc7cfbc2e33f056ab59397f";
  };

  dapp2nix = fetchGit {
    url = "https://github.com/icetan/dapp2nix";
    rev = "5d433e6d5d8b89da808a51a3c8a0559893efbaf5";
    ref = "v2.1.7";
  };

  abi-to-dhall = fetchGit {
    url = "https://github.com/icetan/abi-to-dhall";
    rev = "c7e8518c6c8ef3ab6e6b0cf7c141dc8956dfaae3";
    ref = "v1.0.1";
  };
}
