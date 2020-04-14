# Maker Nix Packages

`makerpkgs` is a Nix package set with common Maker tools.

## Usage

### Adding binary cache

Add the Maker Nix build cache for faster install times:

```sh
nix run nixpkgs.cachix -c cachix use maker
```

### Installing a program from makerpkgs

Installing `seth` from `makerpkgs`:

```sh
nix-env -iA seth -f https://github.com/makerdao/makerpkgs/tarball/master
```

### Using makerpkgs in another Nix expression

Put the following at the top of your `default.nix`:

```nix
{ pkgs ? import (fetchGit "https://github.com/makerdao/makerpkgs") {}
}:
```

**Recommended**: Pin a package set at a certain revision by specifying `rev`
with the commit hash you wish to pin it at:

```nix
{ pkgs ? import (fetchGit {
    url = "https://github.com/makerdao/makerpkgs";
    rev = "86958dbb74d0f2e5a22bc0f397fe943140dfef41";
  }) {}
}:
```

You can also specify `ref` to point to a GIT branch or tag in combination with
or without `rev`.
