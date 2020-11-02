# Maker Nix Packages

`makerpkgs` is a Nix package set with common Maker tools.

## Usage

### Adding binary cache

Add the Maker Nix build cache for faster install times:

```sh
nix run nixpkgs.cachix -c cachix use maker
```

### Installing a program from makerpkgs

List `makerpkgs` specific packages:

```sh
nix-env -f https://github.com/makerdao/makerpkgs/tarball/master --description \
  -qaPA makerpkgs
```

Search for a package:

```sh
nix search -f https://github.com/makerdao/makerpkgs/tarball/master seth
```

Installing `seth` from `makerpkgs`:

```sh
nix-env -f https://github.com/makerdao/makerpkgs/tarball/master -iA seth
```

List available `dapptools` versions:

```sh
nix-env -f https://github.com/makerdao/makerpkgs/tarball/master --description \
  -qaPA dappSources
```

Versions are then available under the path `dappPkgsVersions.<version>`.

Installing `seth` from `dapptools` version `0.26.0`:

```sh
nix-env -f https://github.com/makerdao/makerpkgs/tarball/master \
  -iA dappPkgsVersions.dapp-0_26_0.seth
```

### Using makerpkgs in another Nix expression

Put the following at the top of your `default.nix`:

```nix
{ pkgs ? import (fetchTarball "https://github.com/makerdao/makerpkgs/tarball/master") {}
}:
```

**Recommended**: Pin a package set at a certain revision by specifying the
commit hash you wish to pin it at:

```nix
{ pkgs ? import (fetchTarball "https://github.com/makerdao/makerpkgs/tarball/86958dbb74d0f2e5a22bc0f397fe943140dfef41") {}
}:
```
