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
  ipfs.nix           # IPFS (Kubo) node configuration
```

Every file in `modules/` is a flake-parts module
implementing a single aspect (feature) across all configuration classes.

## Hosts

| Host | System       | Description     | Build                                                     |
| ---- | ------------ | --------------- | --------------------------------------------------------- |
| vm   | x86_64-linux | Virtual machine | nix build .#nixosConfigurations.vm.config.system.build.vm |

## Networking

The VM uses bridged networking via a TAP device,
giving it a routable IP (`192.168.100.2`) accessible directly from the host.

### Host setup (one-time)

Create the bridge and enable NAT for guest internet access:

```bash
sudo ip link add br-vm type bridge
sudo ip addr add 192.168.100.1/24 dev br-vm
sudo ip link set br-vm up

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s 192.168.100.0/24 ! -o br-vm -j MASQUERADE
```

### Before each VM start

Create and attach the TAP device:

```bash
sudo ip tuntap add dev tap-vm mode tap user $USER
sudo ip link set tap-vm master br-vm
sudo ip link set tap-vm up
```

### After VM shutdown

Remove the TAP device:

```bash
sudo ip tuntap del dev tap-vm mode tap
```

[dendritic]: https://github.com/mightyiam/dendritic
[flake-parts]: https://github.com/hercules-ci/flake-parts
