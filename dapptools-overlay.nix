{ fetchgit, dapptoolsOverrides ? {} }:

# To generate `sha256` hash use:
#
#   `nix-prefetch-git --fetch-submodules https://github.com/dapphub/dapptools <COMMIT_HASH>`

let
  fetchDapptoolsVersion = { rev, sha256, version ? rev }: (fetchgit {
    inherit rev sha256;
    url = "https://github.com/dapphub/dapptools";
    fetchSubmodules = true;
  }).overrideAttrs (attrs: {
    meta.description = "Dapptools source @ ${version}";
  });
in rec {
  default = hevm-0_41_0;
  latest = hevm-0_41_0;

  hevm-0_41_0 = fetchDapptoolsVersion {
    version = "hevm-0.41.0";
    rev = "34b2799a26623464c4ab8b7900c6b268adf7d36f";
    sha256 = "13c5v2n1jbzgwwif8rm250dvznxzmypv37xl2075a1dh6jncwhiq";
  };

  master-20200622 = fetchDapptoolsVersion {
    version = "master-20200622";
    rev = "3c86b8008c14711de6e99a97634ea7b21cd34df8";
    sha256 = "1yw93xmgrmm5ppckf2nhyqijmdr7f7s195clkyijd2w8y0dj1f53";
  };

  dapp-0_27_0 = fetchDapptoolsVersion {
    version = "dapp-0.27.0";
    rev = "8f6c557d19a41c3b3d8ad8be7ecf7e90afd0af89";
    sha256 = "0w6gsvhkr7gg64bfnngdggxg5lz8jqmf4ppn0djxfhd9hjay7bzz";
  };

  seth-0_8_4 = fetchDapptoolsVersion {
    version = "seth-0.8.4";
    rev = "72f23c671495e48e2a9558b753c111121fa2c2a8";
    sha256 = "1h9wllbgnwyrpqyvij70zgk0n9d1gg5qy46l5bgpf4b58092547d";
  };

  dapp-0_26_0 = fetchDapptoolsVersion {
    version = "dapp-0.26.0";
    rev = "eb2380c990179ada97fc1ee376ad6f2a32bfe833";
    sha256 = "0x3pf08qnxdlsfcv5wj62dhkfq24ngi0g4q5g7dy8c422k1mvmf9";
  };

  hevm-0_28 = fetchDapptoolsVersion {
    version = "hevm-0.28";
    rev = "214632b08a39872d50ceb3a726b0ca2d70d19e06";
    sha256 = "1qa3rrk51pjm2r8jnz294mj6x5qaxwzz6lzznnzy0782q5s1m5pr";
  };

  dapp-0_19_0 = fetchDapptoolsVersion {
    version = "dapp-0.19.0";
    rev = "10388fb8083e9b3aff53a48afb65c746ade7093b";
    sha256 = "0hynnfgvyjwhzxkpbfnwvazvgcvgvb20rar56cji2ybig0kfaz7f";
  };

  dapp-0_18_1 = fetchDapptoolsVersion {
    version = "dapp-0.18.1";
    rev = "7207c0a92f0aaa19b60c84c14c1ed078892b0436";
    sha256 = "05vryrd8377bi3k8igvhzhjcbp7sq5jsmn75nm71z41yyvlhmrj2";
  };

  dapp-0_18_0 = fetchDapptoolsVersion {
    version = "dapp-0.18.0";
    rev = "deb8b07972a28c4753c82215ed0c0c5b94cb8e31";
    sha256 = "11l5rchvs7zbi02wjkfd5i25bv5ypjjh1bcdq3q2xb337ismgncb";
  };

  dapp-0_16_0 = fetchDapptoolsVersion {
    version = "dapp-0.16.0";
    rev = "6943c76bfb8e0b1fce54c3d9bba6f0f7e50d2f5c";
    sha256 = "0w2fhwh4r6lzgvdav2vdm4wglydc7i6h461zfn91dh09sqjpzzfw";
  };
} // dapptoolsOverrides
