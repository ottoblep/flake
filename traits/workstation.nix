/*
  A trait for headed
*/
{ config, pkgs, lib, ... }:

{
  config = {
    hardware.video.hidpi.enable = true;
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

    # These should only be GUI applications that are desired systemwide
    environment.variables = {
      # VDPAU_DRIVER = "radeonsi";
    };
    environment.systemPackages = with pkgs; [
      ffmpeg
    ];

    services.printing.enable = true;
  };
}

