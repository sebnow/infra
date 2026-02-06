{ ... }:
{
  flake.modules.nixos.node-exporter = {
    services.prometheus.exporters.node.enable = true;

    networking.firewall.allowedTCPPorts = [ 9100 ];
  };
}
