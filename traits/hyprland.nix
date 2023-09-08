{ config, pkgs, lib, ... }:

{
  config = {
    services.xserver = {
      enable = true;
      layout = "de";
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    hardware = {
      opengl.enable = true;
    };

    # hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    programs.waybar.enable = true;
    security.polkit.enable = true;
    environment.systemPackages = with pkgs; [
      dunst
      polkit-kde-agent
      xdg-desktop-portal-hyprland
      pipewire
      wireplumber
      rofi-wayland
    ];
  };
}


