# MakerDAO Nix Packages

Create a `pkgs.nix` file with and update `rev` to a relevant commit hash:

```
import (fetchGit {
  url = "https://github.com/makerdao/nixpkgs-pin";
  rev = "d4b7fe56b38236566b3014d328be1bd9c7be7a2f";
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
