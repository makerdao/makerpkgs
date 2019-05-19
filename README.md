# MakerDAO Nix Packages

Create a `pkgs.nix` file with and update `rev` to a relevant commit hash:

```
import (fetchGit {
  url = "https://github.com/makerdao/nixpkgs-pin";
  rev = "0c952ccdd01e2f30844705bc59c61dd44cfe77d7";
  ref = "master";
})
```

Then put the following in your `default.nix` to be able to inject and override
`nixpkgs` source:

```
{ pkgsSrc ? (import ./pkgs.nix {}).pkgsSrc
, pkgs ? (import ./pkgs.nix { inherit pkgsSrc; }).pkgs
}: with pkgs;
```
