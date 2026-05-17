/*
  Base programs for headed machines
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      keepassxc
      speedcrunch
      pdftk
      pdfgrep
      pandoc
      drawio
      nil
      mouseless
    ];

    systemd.services.mouseless = {
      description = "Mouseless mouse replacement daemon";
      wantedBy = [ "graphical.target" ];
      after = [ "display-manager.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.mouseless}/bin/mouseless --config /home/sevi/.config/mouseless/config.yaml";
        Restart = "always";
        User = "root";
      };
    };
  };
}
