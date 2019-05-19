# MakerDAO Nix Packages

Create a `pkgs.nix` file with and update `rev` to a relevant commit hash:

```
import (fetchGit {
  url = "https://github.com/makerdao/nixpkgs-pin";
  rev = "22f6dc56fc3c79ba9f1e7ac2e284df4a29b8fabc";
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
