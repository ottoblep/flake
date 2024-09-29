{ pkgs, ... }:
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

    # LV2 Plugins for Carla
    ".lv2/b_synth".source = "${pkgs.setbfree}/lib/lv2/b_synth";
    ".lv2/b_whirl".source = "${pkgs.setbfree}/lib/lv2/b_whirl";
    ".lv2/fomp.lv2".source = "${pkgs.fomp}/lib/lv2/fomp.lv2";
    ".lv2/aether.lv2".source = "${pkgs.aether-lv2}/lib/lv2/aether.lv2";
    ".lv2/sfizz.lv2".source = "${pkgs.sfizz}/lib/lv2/sfizz.lv2";
    ".sfz/epianos".source = pkgs.fetchFromGitHub {
      owner = "sfzinstruments";
      repo = "GregSullivan.E-Pianos";
      rev = "8c3e581acda3594b553948ff0222d4f84a698376";
      sha256 = "sha256-tpPNz1ev6AcoTfPMGbfTTTu2wbp6OG1m0f6pCJi9KAM=";
    };
  };
}
