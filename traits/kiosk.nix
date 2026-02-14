
{ config, pkgs, lib, ... }:
{
  config = {
    # Enable autologin for the user 'sevi'
    services.xserver.displayManager.gdm.autoLogin = {
      enable = true;
      user = "sevi";
    };

    # Autostart Firefox
    systemd.user.services."autostart-firefox" = {
      description = "Autostart Firefox";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.firefox}/bin/firefox";
      };
    };
  };
}