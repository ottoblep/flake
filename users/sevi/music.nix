{ config, pkgs, lib, ... }:
{
  home.file = {
    # LV2 Plugins for Carla
    ".lv2/b_synth".source = "${pkgs.setbfree}/lib/lv2/b_synth";
    ".lv2/b_whirl".source = "${pkgs.setbfree}/lib/lv2/b_whirl";
    ".lv2/fomp.lv2".source = "${pkgs.fomp}/lib/lv2/fomp.lv2";
    ".lv2/aether.lv2".source = "${pkgs.aether-lv2}/lib/lv2/aether.lv2";
    ".lv2/sapistaEQv2.lv2".source = "${pkgs.eq10q}/lib/lv2/sapistaEQv2.lv2";
    ".lv2/Surge XT.lv2".source = "${pkgs.surge-XT}/lib/lv2/Surge XT.lv2";
    ".lv2/Surge XT Effects.lv2".source = "${pkgs.surge-XT}/lib/lv2/Surge XT Effects.lv2";
    ".lv2/drumgizmo.lv2".source = "${pkgs.drumgizmo}/lib/lv2/drumgizmo.lv2";
    ".lv2/ChowKick.lv2".source = "${pkgs.ChowKick}/lib/lv2/ChowKick.lv2";
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
    ".sfz/SalamanderGrandPiano".source = pkgs.fetchFromGitHub {
      owner = "sfzinstruments";
      repo = "SalamanderGrandPiano";
      rev = "3382bf9496bba2486f5ab0de55a264d1dfc38404";
      sha256 = "sha256-PpTh8QPHgtU6JGYKZkbBrIhlQMg+ykJBGlOzge9Qfl8=";
    };
    ".sfz/MatsHelgesson.MaestroConcertGrandPiano".source = pkgs.fetchFromGitHub {
      owner = "sfzinstruments";
      repo = "MatsHelgesson.MaestroConcertGrandPiano";
      rev = "717078b450eccc4a7733755f4b5973426ebc23e9";
      sha256 = "sha256-NFN44XQ/qKLSHL6LfXclDGZzoDYocwObrfDDz1E6pP8=";
    };
    ".sfz/SamsSonor".source = pkgs.fetchFromGitHub {
      owner = "sfzinstruments";
      repo = "SamsSonor";
      rev = "ef3e32058924ed1c3335e86d03094d3f310a9104";
      sha256 = "sha256-nZMQp0gfFT+SJFVhB3R96UXnW9pX1L869Ex/qFULpPY=";
    };
  };
}

