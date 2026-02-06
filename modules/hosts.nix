{ config, ... }:
let
  inherit (config.flake.modules) nixos;
in
{
  configurations.nixos.vm.module = {
    imports = [
      nixos.vm
      nixos.ssh
      nixos.admin
    ];

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
