/*
  A trait for headed boxxen
*/
{ config, pkgs, lib, ... }:

{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "de";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    gnome.gnome-keyring.enable = true;
    dbus.packages = with pkgs; [ dconf ];
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs; [
    cheese # webcam tool
    gnome-music
    pkgs.gedit # text editor
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    totem # Video Player (replace with vlc)
    gnome-contacts
    gnome-initial-setup
    decibels
  ]);

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-characters
    vlc # Replaces totem
  ];

  programs.dconf.enable = true;
}

