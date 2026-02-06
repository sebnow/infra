{ ... }:
{
  flake.modules.nixos.grafana = {
    services.grafana = {
      enable = true;
      settings.server = {
        http_addr = "0.0.0.0";
        http_port = 3001;
      };
      provision.datasources.settings.datasources = [
        {
          name = "Mimir";
          type = "prometheus";
          url = "http://localhost:9009/prometheus";
          isDefault = true;
        }
      ];
    };

    networking.firewall.allowedTCPPorts = [ 3001 ];
  };
}
