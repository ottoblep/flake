{ pkgs, lib, ... }:
{
  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.space-bar
    gnomeExtensions.paperwm
    gnomeExtensions.transparent-top-bar
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-dock
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.unite
    dconf2nix
  ];
}