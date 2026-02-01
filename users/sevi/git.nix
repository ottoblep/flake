{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Severin Lochschmidt";
        email = "seviron53@gmail.com";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    lfs.enable = true;
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
