{ ... }:
{
  flake.modules.nixos.vm = { lib, modulesPath, ... }: {
    imports = [
      "${modulesPath}/virtualisation/qemu-vm.nix"
    ];

    fileSystems."/" = {
      device = "/dev/vda1";
      fsType = "ext4";
    };

    boot.loader.grub = {
      enable = true;
      device = "/dev/vda";
    };

    virtualisation = {
      memorySize = 2048;
      cores = 2;
      graphics = false;
      vlans = [];
      qemu.networkingOptions = lib.mkForce [
        "-netdev tap,id=net0,ifname=tap-vm,script=no,downscript=no"
        "-device virtio-net-pci,netdev=net0"
      ];
    };

    networking = {
      usePredictableInterfaceNames = false;
      interfaces.eth0.ipv4.addresses = [{ address = "192.168.100.2"; prefixLength = 24; }];
      defaultGateway = "192.168.100.1";
      nameservers = [ "1.1.1.1" "1.0.0.1" ];
    };

    system.stateVersion = "25.05";
  };
}
