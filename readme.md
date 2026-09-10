# Atelier-Iris
> Part of the Atelier (codename for personal usage) set of projects!  
> NixOS Configuration managing 3 machines, built with flakes and home-manager.

## Overview
This configuration manages my desktop (#Selene), laptop (#Crescent), and homelab server (#Copernicus). Note that the names of each machine relate to words related to the moon. It also includes configuration settings for VM use with `build-vm` and `build-vm-with-bootloader`. This configuration is focused on creating reusable modules that can be shared across devices, allowing for convenient reproducibility for current and future devices.

## Structure
```
- flake.nix
- flake.lock
- hosts/
    - selene/
        - default.nix
        - hardware.nix
    - crescent/
        - default.nix
        - hardware.nix
    - copernicus/
        - default.nix
        - hardware.nix
- modules/
    - nixos/...
    - home/...
- common/
    - default.nix
    - home.nix
```

Note: common/ files are the "default" configuration for all the hosts, importing all commonly used modules. Overrides for each host is contained in hosts/. 

## Notes
- Custom Flake Inputs for Zen-browser, and [Horologium](https://git.starrytea.cc/Constellation-Project/Horologium).
- Currently uses a local impure package for [Pyxis](https://github.com/Stelare-Rose/Pyxis) because Pyxis hasn't been updated to use a flake.
- Uses a Forgejo Action every Monday to run `nix flake update` and push to the repo, making flake version updates centralized.

## Usage
```bash
sudo nixos-rebuild switch --flake ~/Atelier-Iris#<flake> --impure
```
Note that impure is required for Pyxis

## Requirements
- NixOS with Flakes Enabled
- Note that specific flakes may have specific hardware configurations (e.g. Monitor Size), so may not function properly on certain hardware.

## Commit Guidelines

This repo loosely follows [Conventional Commits](https://www.conventionalcommits.org/),
with a few personal deviations:

- Usage of mixed upper-lowercase commits rather than pure lowercase.
- `Feat` is used broadly. Anything that isn't a `Fix`, `Chore`, or another
  specific type falls under `Feat`.
- For changes scoped to a single machine, use `(type)[machine]: message`
  — e.g. `Feat[Selene]: Add gaming module`.
- `Minor` is a custom type reserved for small, low-stakes changes like
  toggling a service on/off.

## Credits
Thanks to [0xc000022070](https://github.com/0xc000022070) for the Zen-browser flake that I use in this configuration. Thank you to the [Catppuccin](https://github.com/catppuccin) team, as the catppuccin theme is used, and has influenced many parts of this configuration.
