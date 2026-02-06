{ ... }:
let
  userName = "admin";
in
{
  flake.modules.nixos.admin = {
    users.users.${userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/G/lmn6AOltQgAKks/7TNqzFOaizW1eCcDSuj2GPOr"
      ];
    };
  };
}
