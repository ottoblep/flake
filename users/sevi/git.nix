{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Severin Lochschmidt";
    userEmail = "seviron53@gmail.com";
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
    ignores = [
      ".vscode"
      "*.bkp"
      "result"
      "notes.md"
      "hs_*.sh"
      "extra_documents"
    ];
  };
}