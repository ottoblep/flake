/*
  Kiosk Mode

  Provides a minimal desktop kiosk setup using an autologin user and
  Openbox to launch Firefox in kiosk mode.
*/
{ config, pkgs, lib, ... }:
let
  kioskUsername = "kiosk";
  browser = pkgs.firefox;
  autostart = ''
    #!${pkgs.bash}/bin/bash
    firefox --kiosk  https://duckduckgo.com/ &
  '';

  inherit (pkgs) writeScript;
in {
  config = {
    users.users = {
      "${kioskUsername}" = {
        group = kioskUsername;
        isNormalUser = true;
        packages = [ browser ];
      };
    };
    users.groups."${kioskUsername}" = {};

    # Configure X11
    services.xserver = {
      enable = true;
      layout = "de";
      libinput.enable = true;

      # Let lightdm handle autologin
      displayManager.lightdm = {
        enable = true;
        autoLogin = {
          enable = true;
          timeout = 0;
          user = kioskUsername;
        };
      };

      windowManager.openbox.enable = true;
      displayManager.defaultSession = "none+openbox";
    };

    nixpkgs.overlays = with pkgs; [
      (self: super: {
        openbox = super.openbox.overrideAttrs (oldAttrs: rec {
          postFixup = ''
            ln -sf /etc/openbox/autostart $out/etc/xdg/openbox/autostart
          '';
        });
      })
    ];

    environment.etc."openbox/autostart".source = writeScript "autostart" autostart;
  };
}