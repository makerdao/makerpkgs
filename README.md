# MakerDAO Nix Packages

Then put the following in your `default.nix`:

```
{ pkgs ? import (fetchGit {
    url = "https://github.com/makerdao/nixpkgs-pin";
    ref = "master";
  }) {}
}:
```

To freeze at a certain revision of this repo set `rev` to the commit hash you
wish to pin:

```
{ pkgs ? import (fetchGit {
    url = "https://github.com/makerdao/nixpkgs-pin";
    ref = "master";
    rev = "aa8cea6eef397cb3c551b9e41f54f8f9f230fd9b";
  }) {}
}:
```

