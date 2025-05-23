{ pkgs, lib, config, ... }:
{
  imports = [ ./dconf.nix ];

  home.packages =
    with pkgs; with pkgs.gnomeExtensions;
    [
      graphite-cursors
      # rounded-window-corners # As soon as available for 45
      rounded-corners
      user-themes
      paperwm
      just-perfection
      unite
      dconf2nix
      # For vsc transparency
      wmctrl
      xorg.xprop
    ];

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-macchiato-mauve-compact+rimless"; # This will be added to dconf to select the accent color
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach" "red" "sapphire" "sky" "teal" ]; # You can specify multiple accents here to output multiple themes
        size = "compact";
        tweaks = [ "rimless" ]; # You can also specify multiple tweaks here
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Service for fetching and color-filtering new wallpaper images
  systemd.user.services."wallpaper-fetcher" =
    let
      # palette-1 = pkgs.fetchurl {
      #   url = "https://raw.githubusercontent.com/catppuccin/catppuccin/03f1d0557c41331a61871a01b52e343315fdbff8/assets/palette/macchiato.png";
      #   hash = "sha256-G4NkibJk5HGOcKh6jc1cJnQyqdNetX72ysxeFPirW/w=";
      # };
      # palette-2 = pkgs.fetchurl {
      #   url = "https://raw.githubusercontent.com/catppuccin/catppuccin/03f1d0557c41331a61871a01b52e343315fdbff8/assets/palette/night.png";
      #   hash = "sha256-ZbKJoStbyd5lYukpuflN66UPNlEceRtBG1D+T8t669A=";
      # };
      script = pkgs.writeShellScriptBin "fetch-wallpaper" ''
        export PATH=$PATH:${lib.makeBinPath [ pkgs.coreutils pkgs.jq pkgs.curl pkgs.imagemagick pkgs.gnome-shell ]}
        export WD=/home/sevi/.cache/wallpaper-fetcher
        export WPD=/home/sevi/Pictures/Wallpapers
        export META=$(curl 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=2&mkt=en-US')

        mkdir -p $WPD
        mkdir -p $WD

        curl -o $WD/wallpaper_raw_1.jpg "https://bing.com$(echo $META| jq -r '.images[0].url')"
        curl -o $WD/wallpaper_raw_2.jpg "https://bing.com$(echo $META| jq -r '.images[1].url')"
        convert $WD/wallpaper_raw_1.jpg -paint 5 $WD/wallpaper_raw_1.jpg
        convert $WD/wallpaper_raw_2.jpg -paint 5 $WD/wallpaper_raw_2.jpg
        cp $WD/wallpaper_raw_1.jpg $WPD/wallpaper.png
        cp $WD/wallpaper_raw_2.jpg $WPD/wallpaper2.png

        gnome-extensions reset paperwm@paperwm.github.com
        gnome-extensions enable paperwm@paperwm.github.com
      '';
      # convert -append ${palette-1} ${palette-2} $WD/palette.png
      # convert $WD/wallpaper_raw_1.jpg -remap $WD/palette.png $WD/wallpaper_raw_1.jpg
      # convert $WD/wallpaper_raw_2.jpg -remap $WD/palette.png $WD/wallpaper_raw_2.jpg
    in
    {
      Service = {
        Type = "simple";
        ExecStart = "${script}/bin/fetch-wallpaper";
      };
      Install.WantedBy = [ "gnome-session-initialized.target" ];
    };

  # Default Apps
  home.file.".config/mimeapps.list" = {
    source = ../dotfiles/mimeapps.list;
    force = true;
  };
}
