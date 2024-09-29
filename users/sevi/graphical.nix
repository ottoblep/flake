{ config, pkgs, lib, ... }:
{
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock-origin
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "bkdgflcldnnnapblkhphbgpggdiikppg" # duckduckgo
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "cmpdlhmnmjhihmcfnigoememnffkimlk" # Catppuccin Macchiato
    ];
  };

  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
  };

  home.file = {
    # Can't yet use the builtin parser because it produces yaml
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
    ".config/alacritty/catppuccin-macchiato.toml".source =
      let
        src = pkgs.fetchFromGitHub {
          repo = "alacritty";
          owner = "catppuccin";
          rev = "071d73effddac392d5b9b8cd5b4b527a6cf289f9";
          hash = "sha256-HiIYxTlif5Lbl9BAvPsnXp8WAexL8YuohMDd/eCJVQ8=";
        };
      in
      "${src}/catppuccin-macchiato.toml";

    ".config/openrazer/persistence.conf".source = ./dotfiles/openrazer.conf;
    ".config/xournalpp/settings.xml".source = ./dotfiles/xournalpp.xml;
  };
}
