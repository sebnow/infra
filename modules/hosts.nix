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
      nixos.ipfs
      nixos.adguardhome
      nixos."node-exporter"
      nixos.prometheus
      nixos.grafana
      nixos.mimir
    ];

    nixpkgs.hostPlatform = "x86_64-linux";

    monitoring.scrapeTargets = [ "localhost:9100" ];
  };
}
