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

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # Autostart Graphical Program
  home.file.".config/autostart/lrz-sync-share.desktop".source = "${lrzSnSDesktopItem}/share/applications/lrz-sync-share.desktop";
}
