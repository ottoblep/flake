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
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
    ".config/alacritty/alacritty-macchiato.toml".source = ./dotfiles/alacritty-macchiato.toml;
    ".config/openrazer/persistence.conf".source = ./dotfiles/openrazer.conf;
    ".config/xournalpp/settings.xml".source = ./dotfiles/xournalpp.xml;
  };

  home.packages = with pkgs; [
    crush_custom # LLM Agent doing stuff in the terminal
  ];
}
