{ pkgs, lib, config, ... }:
{
  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    graphite-cursors
    dconf2nix
    # For vsc transparency
    wmctrl
    xprop
  ];

  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
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

  # Default Apps
  home.file.".config/mimeapps.list" = {
    source = ../dotfiles/mimeapps.list;
    force = true;
  };
}
