/*
  A trait for headed
*/
{ config, pkgs, lib, ... }:

{
  config = {
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.extraPackages = with pkgs; [ libvdpau vdpauinfo libvdpau-va-gl ];

    fonts.fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      hinting.style = "hintfull";
    };

    fonts.enableDefaultFonts = true;
    fonts.fonts = with pkgs; [
      noto-fonts
    ];

    environment.systemPackages = with pkgs; [
    ];

    services.printing.enable = true;
    hardware.sane.enable = true;
  };
}

