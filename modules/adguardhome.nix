{ ... }:
{
  flake.modules.nixos.adguardhome = {
    services.adguardhome = {
      enable = true;
      mutableSettings = false;
      settings = {
        http.address = "0.0.0.0:3000";
        dns = {
          bind_hosts = [ "0.0.0.0" ];
          port = 53;
          bootstrap_dns = [
            "1.1.1.1"
            "1.0.0.1"
          ];
          upstream_dns = [
            "1.1.1.1"
            "1.0.0.1"
          ];
        };
        filtering.rewrites = [];
        filters = [
          { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"; name = "AdGuard DNS filter"; id = 1; }
          { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt"; name = "AdAway Default Blocklist"; id = 2; }
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [ 53 3000 ];
    networking.firewall.allowedUDPPorts = [ 53 ];
  };
}
