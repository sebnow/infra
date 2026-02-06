{ lib, ... }:
{
  flake.modules.nixos.prometheus = { config, ... }: {
    options.monitoring.scrapeTargets = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of host:port targets for Prometheus to scrape.";
    };

    config = {
      services.prometheus = {
        enable = true;
        scrapeConfigs = [
          {
            job_name = "node";
            static_configs = [
              { targets = config.monitoring.scrapeTargets; }
            ];
          }
        ];
        remoteWrite = [
          { url = "http://localhost:9009/api/v1/push"; }
        ];
      };

      networking.firewall.allowedTCPPorts = [ 9090 ];
    };
  };
}
