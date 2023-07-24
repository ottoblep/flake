{ lib, ... }:

{
  config = {
    services.openssh.enable = true;
    services.openssh.settings.PasswordAuthentication = false;
    services.openssh.settings.PermitRootLogin = lib.mkForce "no";

    # networking.firewall.allowedTCPPorts = [ 22 ];
    # networking.firewall.allowedUDPPorts = [ 22 ];

    services.openssh.hostKeys = [
    ];
  };
}

