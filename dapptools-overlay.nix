{ fetchgit, dapptoolsOverrides ? {} }:

# To generate `sha256` hash use:
#
#   `nix-prefetch-git --fetch-submodules https://github.com/dapphub/dapptools <COMMIT_HASH>`

let
  fetchDapptoolsVersion = { rev, sha256 }: fetchgit {
    inherit rev sha256;
    url = "https://github.com/dapphub/dapptools";
    fetchSubmodules = true;
  };
in
  rec {
    current = latest;

    latest = fetchDapptoolsVersion {
      rev = "45b8d4626d90c5a9f76aea88169dde8f558b7c7a";
      sha256 = "1x9yn9h890567sy4qfkxnr4ijz2ycavdyizc6c52shyrj5mhf3g3";
    };

    dapp-0_16_0 = fetchDapptoolsVersion {
      rev = "6943c76bfb8e0b1fce54c3d9bba6f0f7e50d2f5c";
      sha256 = "0w2fhwh4r6lzgvdav2vdm4wglydc7i6h461zfn91dh09sqjpzzfw";
    };

    dapp-0_18_0 = fetchDapptoolsVersion {
      rev = "deb8b07972a28c4753c82215ed0c0c5b94cb8e31";
      sha256 = "11l5rchvs7zbi02wjkfd5i25bv5ypjjh1bcdq3q2xb337ismgncb";
    };

    dapp-0_18_1 = fetchDapptoolsVersion {
      rev = "7207c0a92f0aaa19b60c84c14c1ed078892b0436";
      sha256 = "05vryrd8377bi3k8igvhzhjcbp7sq5jsmn75nm71z41yyvlhmrj2";
    };

    dapp-0_19_0 = fetchDapptoolsVersion {
      rev = "10388fb8083e9b3aff53a48afb65c746ade7093b";
      sha256 = "0hynnfgvyjwhzxkpbfnwvazvgcvgvb20rar56cji2ybig0kfaz7f";
    };

    hevm-0_28 = fetchDapptoolsVersion {
      rev = "214632b08a39872d50ceb3a726b0ca2d70d19e06";
      sha256 = "1qa3rrk51pjm2r8jnz294mj6x5qaxwzz6lzznnzy0782q5s1m5pr";
    };
  } // dapptoolsOverrides
