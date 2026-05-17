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
    package = (pkgs.unstable.alacritty.overrideAttrs (old: rec {
        version = "0.17.0-dev";
        src = pkgs.fetchFromGitHub {
          owner = "GregTheMadMonk";
          repo = "alacritty-smooth-cursor";
          rev = "master";
          hash = "sha256-WgfXJYdCJDkcM2CJrIYWYUldpz6U/vgQIlEJKkNiFc0=";
        };
        cargoDeps = pkgs.unstable.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-pbDuSvlTEUdf23LFXxK17UsXUzTUQsnnypoduUdsm+c=";
        };
        postPatch = (old.postPatch or "") + ''
          sed -i '614s/`/\"/g' extra/man/alacritty.5.scd
        '';
      }));
  };

  home.file = {
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
    ".config/alacritty/alacritty-macchiato.toml".source = ./dotfiles/alacritty-macchiato.toml;
    ".config/openrazer/persistence.conf".source = ./dotfiles/openrazer.conf;
    ".config/xournalpp/settings.xml".source = ./dotfiles/xournalpp.xml;
    ".config/mouseless/config.yaml".source = ./dotfiles/mouseless.yaml;
  };
}
