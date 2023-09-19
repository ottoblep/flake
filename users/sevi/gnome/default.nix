{ pkgs, lib, ... }:
{
  imports = [ ./dconf.nix ];

  home.packages = with pkgs.gnomeExtensions; [
    user-themes
    hide-top-bar
    paperwm
    vitals
    bing-wallpaper-changer
    just-perfection
    transparent-top-bar
    pkgs.dconf2nix
  ];
}