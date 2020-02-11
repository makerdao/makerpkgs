{
  nixpkgs = fetchGit {
    url = "https://github.com/nixos/nixpkgs-channels";
    ref = "nixos-19.09";
    rev = "ea553d8c67c6a718448da50826ff5b6916dc9c59";
  };

  sethret = fetchGit {
    url = https://github.com/icetan/sethret.git;
    rev = "ef77915e2881011603491275f36b44bf2478b408";
  };

  dapp2nix = fetchGit {
    url = "https://github.com/icetan/dapp2nix";
    ref = "v2.1.7";
    rev = "5d433e6d5d8b89da808a51a3c8a0559893efbaf5";
  };

  abi-to-dhall = fetchGit {
    url = "https://github.com/icetan/abi-to-dhall";
    rev = "c7e8518c6c8ef3ab6e6b0cf7c141dc8956dfaae3";
    ref = "v1.0.1";
  };
}
