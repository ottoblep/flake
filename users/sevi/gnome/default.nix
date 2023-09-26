{ pkgs, lib, ... }:
{
  imports = [ ./dconf.nix ];

  home.packages = with pkgs.gnomeExtensions; [
    user-themes
    paperwm
    bing-wallpaper-changer
    just-perfection
    unite
    pkgs.dconf2nix
    pkgs.flat-remix-gnome
  ];
}
