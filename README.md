# MakerDAO Nix Packages

Create a `pkgs.nix` file with and update `rev` to a relevant commit hash:

```
import (fetchGit {
  url = "https://github.com/makerdao/nixpkgs-pin";
  rev = "16427c46f6472c040a600a527dd9da6e505c8b8e";
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
