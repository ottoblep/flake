/*
  A trait for headed boxxen
*/
{ config, pkgs, lib, ... }:

{
  config = {
    services = {
      xserver = {
        enable = true;
        layout = "de";
        displayManager.gdm.enable = true;
        displayManager.autoLogin.enable = false;
        desktopManager.gnome.enable = true;
      };
      gnome.gnome-keyring.enable = true;
      dbus.packages = with pkgs; [ dconf ];
    };
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gedit # text editor
      epiphany # web browser
      geary # email reader
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
    ]);

    environment.systemPackages = with pkgs.gnome; [
      gnome-tweaks
      gnome-characters
    ];

    programs.dconf.enable = true;
  };
}

