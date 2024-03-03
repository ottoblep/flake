{ pkgs, lib, config, ... }:
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
    with pkgs; with pkgs.gnomeExtensions;
    [
      # rounded-window-corners # As soon as available for 45
      rounded-corners
      user-themes
      paperwm
      just-perfection
      unite
      dconf2nix
      nix-lrz-sync-share.lrz-sync-share
      lrzSnSDesktopItem
    ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Flamingo-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach" "pink" "red" "rosewater" "sapphire" "sky" "teal" ]; # You can specify multiple accents here to output multiple themes
        size = "compact";
        tweaks = [ "rimless" ]; # You can also specify multiple tweaks here
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Service for fetching and color-filtering new wallpaper images
  systemd.user.services."wallpaper-fetcher" =
    let
      palette-1 = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/catppuccin/03f1d0557c41331a61871a01b52e343315fdbff8/assets/palette/macchiato.png";
        hash = "sha256-G4NkibJk5HGOcKh6jc1cJnQyqdNetX72ysxeFPirW/w=";
      };
      palette-2 = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/catppuccin/03f1d0557c41331a61871a01b52e343315fdbff8/assets/palette/night.png";
        hash = "sha256-ZbKJoStbyd5lYukpuflN66UPNlEceRtBG1D+T8t669A=";
      };
      script = pkgs.writeShellScriptBin "fetch-wallpaper" ''
        export PATH=$PATH:${lib.makeBinPath [ pkgs.coreutils pkgs.jq pkgs.curl pkgs.imagemagick ]}
        export WD=/home/sevi/.cache/wallpaper-fetcher
        export WPD=/home/sevi/Pictures/Wallpapers
        export META=$(curl 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=2&mkt=en-US')
        mkdir -p $WPD
        mkdir -p $WD
        curl -o $WD/wallpaper_raw_1.jpg "https://bing.com$(echo $META| jq -r '.images[0].url')"
        curl -o $WD/wallpaper_raw_2.jpg "https://bing.com$(echo $META| jq -r '.images[1].url')"
        convert -append ${palette-1} ${palette-2} $WD/palette.png
        convert $WD/wallpaper_raw_1.jpg -map $WD/palette.png $WPD/wallpaper.png
        convert $WD/wallpaper_raw_2.jpg -map $WD/palette.png $WPD/wallpaper2.png
        echo "Wallpaper updated."
      '';
    in
    {
      Service = {
        Type = "simple";
        ExecStart = "${script}/bin/fetch-wallpaper";
      };
      Install.WantedBy = [ "default.target" ];
    };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  # This folder needs to be manually deleted on rebuild for some reason
  # xdg.configFile = {
  #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  # };

  # Autostart Graphical Program
  home.file.".config/autostart/lrz-sync-share.desktop".source = "${lrzSnSDesktopItem}/share/applications/lrz-sync-share.desktop";
}
