{ config, pkgs, lib, ... }:
{
  home.file = {
    # LV2 Plugins for Carla
    ".lv2/b_synth".source = "${pkgs.setbfree}/lib/lv2/b_synth";
    ".lv2/b_whirl".source = "${pkgs.setbfree}/lib/lv2/b_whirl";
    ".lv2/fomp.lv2".source = "${pkgs.fomp}/lib/lv2/fomp.lv2";
    ".lv2/aether.lv2".source = "${pkgs.aether-lv2}/lib/lv2/aether.lv2";
    # Sampler and Samples
    ".lv2/sfizz.lv2".source = "${pkgs.sfizz}/lib/lv2/sfizz.lv2";
    ".sfz/GregSullivan.E-Pianos".source = pkgs.fetchFromGitHub {
      owner = "sfzinstruments";
      repo = "GregSullivan.E-Pianos";
      rev = "8c3e581acda3594b553948ff0222d4f84a698376";
      sha256 = "sha256-tpPNz1ev6AcoTfPMGbfTTTu2wbp6OG1m0f6pCJi9KAM=";
    };
    ".sfz/jlearman.jRhodes3c".source = pkgs.fetchFromGitHub {
      owner = "sfzinstruments";
      repo = "jlearman.jRhodes3c";
      rev = "6d365687b40ac3ae4eed9b43492d27437bcf8adb";
      sha256 = "sha256-s6ZGihjnZmun2/6z8E0ZHldAXGEoz2KrB8SqyF0A0fQ=";
    };
  };
}

