{ ... }:
let
  port = 22;
in
{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      ports = [ port ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    networking.firewall.allowedTCPPorts = [ port ];

    virtualisation.forwardPorts = [
      { from = "host"; host.port = 2222; guest.port = port; }
    ];
  };
}
