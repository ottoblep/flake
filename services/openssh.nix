{ lib, ... }:

{
  config = {
    services.openssh.enable = true;
    services.openssh.settings.passwordAuthentication = false;
    services.openssh.settings.permitRootLogin = lib.mkForce "no";

    # networking.firewall.allowedTCPPorts = [ 22 ];
    # networking.firewall.allowedUDPPorts = [ 22 ];

    services.openssh.hostKeys = [
    ];
  };
}

