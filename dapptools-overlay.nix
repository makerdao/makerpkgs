{ dapptoolsOverrides ? {} }:

let
  fetchDapptoolsVersion = { rev, ref ? "" }: fetchGit {
    inherit rev ref;
    url = "https://github.com/dapphub/dapptools";
  };
in
  rec {
    current = latest;

    latest = fetchDapptoolsVersion {
      rev = "5fd1c522e1ea672214544718cc0699cf058c04f7";
      ref = "hevm/0.32";
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
  }
