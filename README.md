# infra

Nix configuration for infrastructure hosts,
structured using the [Dendritic Pattern][dendritic] with [flake-parts].

## Structure

```
flake.nix            # Inputs and mkFlake — no logic
modules/
  flake-parts.nix    # Imports flake-parts flakeModules.modules
  nixos.nix          # NixOS configuration option and wiring
  systems.nix        # Supported systems for perSystem
  hosts.nix          # Host compositions from aspects
  ssh.nix            # SSH server configuration
  vm.nix             # VM hardware and boot configuration
```

Every file in `modules/` is a flake-parts module
implementing a single aspect (feature) across all configuration classes.

## Hosts

| Host | System       | Description    |
| ---- | ------------ | -------------- |
| vm   | x86_64-linux | Virtual machine |

## Usage

Build a host configuration:

```sh
nix build .#nixosConfigurations.vm.config.system.build.toplevel
```

[dendritic]: https://github.com/mightyiam/dendritic
[flake-parts]: https://github.com/hercules-ci/flake-parts
