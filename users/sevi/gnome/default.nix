{ pkgs, lib, ... }:
{
  imports = [ ./dconf.nix ];

  home.packages = with pkgs.gnomeExtensions; [
    user-themes
    paperwm
    bing-wallpaper-changer
    just-perfection
    pkgs.dconf2nix
    unite
  ];
}