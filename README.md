# MakerDAO Nix Packages

Put the following at the top of your `default.nix`:

```
{ pkgs ? import (fetchGit "https://github.com/makerdao/nixpkgs-pin") {}
}:
```

**Recommended**: Pin a package set at a certain revision by specifying `rev`
with the commit hash you wish to pin it at:

```
{ pkgs ? import (fetchGit {
    url = "https://github.com/makerdao/nixpkgs-pin";
    rev = "aa8cea6eef397cb3c551b9e41f54f8f9f230fd9b";
  }) {}
}:
```

You can also specify `ref` to point to a GIT branch or tag in combination with
or without `rev`.
