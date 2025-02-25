# aloshy.🅰🅸 | NixCfg

## Get started

1. Install Nix

> Make sure to choose `No` for `Determinate` choice

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Switch to Nix Darwin

```
nix run github:lnl7/nix-darwin#darwin-rebuild -- switch --flake .
```