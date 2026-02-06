{ ... }:
{
  flake.modules.nixos.ipfs = {
    services.kubo = {
      enable = true;
      settings = {
        Addresses = {
          API = "/ip4/127.0.0.1/tcp/5001";
          Gateway = "/ip4/127.0.0.1/tcp/8080";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ 4001 ];
    networking.firewall.allowedUDPPorts = [ 4001 ];
  };
}
