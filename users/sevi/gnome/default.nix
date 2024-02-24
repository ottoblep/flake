{ pkgs, lib, ... }:
let
  lrzSnSDesktopItem = pkgs.makeDesktopItem
    {
      name = "lrz-sync-share";
      desktopName = "LRZ Sync and Share";
      exec = "lrz-sync-share";
    };
in
{
  imports = [ ./dconf.nix ];

  home.packages =
    with pkgs.gnomeExtensions;
    [
      # rounded-window-corners # As soon as available for 45
      rounded-corners
      user-themes
      paperwm
      bing-wallpaper-changer
      just-perfection
      unite
      pkgs.dconf2nix
      pkgs.orchis-theme
      pkgs.nix-lrz-sync-share.lrz-sync-share
      lrzSnSDesktopItem
    ];

  # Autostart Graphical Program
  home.file.".config/autostart/lrz-sync-share.desktop".source = "${lrzSnSDesktopItem}/share/applications/lrz-sync-share.desktop";
}
