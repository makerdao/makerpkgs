{ fetchgit, dapptoolsOverrides ? {} }:

# To generate `sha256` for `fetchTarball` do:
#
# $ nix-prefetch-url --unpack https://github.com/dapphub/dapptools/tarball/<COMMIT_HASH>
#

rec {
  default = hevm-0_43_1;
  latest = hevm-0_43_1;

  master-20200217 = fetchTarball {
    name = "dapptools-master-20200217";
    url = "https://github.com/dapphub/dapptools/tarball/9b1fc76ad40ce7bfe76d27c40f1813dce502f082";
    sha256 = "01l4lq9pi3sm8rzficf82dclry6syv2p2ihylj332bkvhfz27jn6";
  };

  master-20200216 = fetchTarball {
    name = "dapptools-master-20200216";
    url = "https://github.com/dapphub/dapptools/tarball/4007d52cbad75de4882614a707695db5110aab51";
    sha256 = "1d8w1ps69nczkn0xhnajb3z9i99wszcsbhhdy2jw62rzf2kn0ki6";
  };

  hevm-0_43_1 = fetchTarball {
    name = "dapptools-hevm-0_43_1";
    url = "https://github.com/dapphub/dapptools/tarball/75809c1ee826af83a65d2fc1411be4a78df7bd59";
    sha256 = "17iwb6q6gkxmqvzaf086xkjq271n5zwrbsz58786bxd6a8ld1r8q";
  };

  seth-0_9_3 = fetchTarball {
    name = "dapptools-seth-0_9_3";
    url = "https://github.com/dapphub/dapptools/tarball/e855b6544270769fe00987fe0265cc1af6bf47a6";
    sha256 = "1pk73qqb78ngwbjbbjn4x80aa6xnhywcy6zyykq7crnfxpgdgmj0";
  };

  hevm-0_42_0 = fetchTarball {
    name = "dapptools-hevm-0_42_0";
    url = "https://github.com/dapphub/dapptools/tarball/0293a01377620ed742a91db115199358d24b065e";
    sha256 = "17y6lq05q7h66dw39n85fri4kx6nxshakl23pkki36nnyrk42iix";
  };
}

// (let
  #
  # Older versions of dapptools uses `fetchDapptoolsVersion` to fetch submodules:
  #
  # To generate `sha256` hash use:
  #
  # $ nix-prefetch-git --fetch-submodules https://github.com/dapphub/dapptools <COMMIT_HASH>
  #
  # DEPRECATED:
  #
  fetchDapptoolsVersion = { rev, sha256, version ? rev }: (fetchgit {
    inherit rev sha256;
    url = "https://github.com/dapphub/dapptools";
    fetchSubmodules = true;
  }).overrideAttrs (attrs: {
    meta.description = "Dapptools source @ ${version}";
  });
in

builtins.mapAttrs (k: v: fetchDapptoolsVersion v) {
  hevm-0_41_0 = {
    version = "hevm-0.41.0";
    rev = "34b2799a26623464c4ab8b7900c6b268adf7d36f";
    sha256 = "13c5v2n1jbzgwwif8rm250dvznxzmypv37xl2075a1dh6jncwhiq";
  };

  master-20200622 = {
    version = "master-20200622";
    rev = "3c86b8008c14711de6e99a97634ea7b21cd34df8";
    sha256 = "1yw93xmgrmm5ppckf2nhyqijmdr7f7s195clkyijd2w8y0dj1f53";
  };

  dapp-0_27_0 = {
    version = "dapp-0.27.0";
    rev = "8f6c557d19a41c3b3d8ad8be7ecf7e90afd0af89";
    sha256 = "0w6gsvhkr7gg64bfnngdggxg5lz8jqmf4ppn0djxfhd9hjay7bzz";
  };

  seth-0_8_4 = {
    version = "seth-0.8.4";
    rev = "72f23c671495e48e2a9558b753c111121fa2c2a8";
    sha256 = "1h9wllbgnwyrpqyvij70zgk0n9d1gg5qy46l5bgpf4b58092547d";
  };

  dapp-0_26_0 = {
    version = "dapp-0.26.0";
    rev = "eb2380c990179ada97fc1ee376ad6f2a32bfe833";
    sha256 = "0x3pf08qnxdlsfcv5wj62dhkfq24ngi0g4q5g7dy8c422k1mvmf9";
  };

  hevm-0_28 = {
    version = "hevm-0.28";
    rev = "214632b08a39872d50ceb3a726b0ca2d70d19e06";
    sha256 = "1qa3rrk51pjm2r8jnz294mj6x5qaxwzz6lzznnzy0782q5s1m5pr";
  };

  dapp-0_19_0 = {
    version = "dapp-0.19.0";
    rev = "10388fb8083e9b3aff53a48afb65c746ade7093b";
    sha256 = "0hynnfgvyjwhzxkpbfnwvazvgcvgvb20rar56cji2ybig0kfaz7f";
  };

  dapp-0_18_1 = {
    version = "dapp-0.18.1";
    rev = "7207c0a92f0aaa19b60c84c14c1ed078892b0436";
    sha256 = "05vryrd8377bi3k8igvhzhjcbp7sq5jsmn75nm71z41yyvlhmrj2";
  };

  dapp-0_18_0 = {
    version = "dapp-0.18.0";
    rev = "deb8b07972a28c4753c82215ed0c0c5b94cb8e31";
    sha256 = "11l5rchvs7zbi02wjkfd5i25bv5ypjjh1bcdq3q2xb337ismgncb";
  };

  dapp-0_16_0 = {
    version = "dapp-0.16.0";
    rev = "6943c76bfb8e0b1fce54c3d9bba6f0f7e50d2f5c";
    sha256 = "0w2fhwh4r6lzgvdav2vdm4wglydc7i6h461zfn91dh09sqjpzzfw";
  };
})

// dapptoolsOverrides
