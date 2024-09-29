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
  # Can't yet use the builtin parser because it produces yaml
  home.file.".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
  home.file.".config/alacritty/catppuccin-macchiato.toml".source =
    let
      src = pkgs.fetchFromGitHub {
        repo = "alacritty";
        owner = "catppuccin";
        rev = "071d73effddac392d5b9b8cd5b4b527a6cf289f9";
        hash = "sha256-HiIYxTlif5Lbl9BAvPsnXp8WAexL8YuohMDd/eCJVQ8=";
      };
    in
    "${src}/catppuccin-macchiato.toml";

  home.file.".config/openrazer/persistence.conf".source = ./dotfiles/openrazer.conf;
  home.file.".config/xournalpp/settings.xml".source = ./dotfiles/xournalpp.xml;

  # LV2 Plugins for Carla
  home.file.".lv2/b_synth".source = "${pkgs.setbfree}/lib/lv2/b_synth";
  home.file.".lv2/b_whirl".source = "${pkgs.setbfree}/lib/lv2/b_whirl";
  home.file.".lv2/fomp.lv2".source = "${pkgs.fomp}/lib/lv2/fomp.lv2";
  home.file.".lv2/aether.lv2".source = "${pkgs.aether-lv2}/lib/lv2/aether.lv2";
}
