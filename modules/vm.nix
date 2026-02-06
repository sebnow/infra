{ ... }:
{
  flake.modules.nixos.vm = { modulesPath, ... }: {
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
    };

    system.stateVersion = "25.05";
  };
}
