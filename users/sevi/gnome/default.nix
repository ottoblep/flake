{ pkgs, lib, ... }:
{
  imports = [ ./dconf.nix ];

  home.packages =
    let
      lrzSnSDesktopItem = pkgs.makeDesktopItem
        {
          name = "lrz-sync-share";
          desktopName = "LRZ Sync and Share";
          exec = "lrz-sync-share";
        };
    in
    with pkgs.gnomeExtensions;
    [
      user-themes
      paperwm
      bing-wallpaper-changer
      just-perfection
      unite
      pkgs.dconf2nix
      pkgs.orchis-theme
      lrzSnSDesktopItem
    ];
}
