{ config, pkgs, ... }:
{
  home.username = "sevi";
  home.homeDirectory = "/home/sevi";

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
      "result"
      "notes.md"
      "extra_documents"
    ];
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fd" "zoxide" "ripgrep" ];
      theme = "gozilla";
    };
  };

  home.file.".config/btop/btop.conf".source = ./dotfiles/btop.conf;
  home.file.".config/btop/themes".source =
    let
      src = pkgs.fetchFromGitHub {
        repo = "btop";
        owner = "catppuccin";
        rev = "1.0.0";
        hash = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
      };
    in
    "${src}/themes";
  home.file.".config/todo-cli.conf".source = ./dotfiles/todo-txt-cli.conf;
  home.file.".vim/".source =
    let
      src = pkgs.fetchFromGitHub {
        repo = "vim";
        owner = "catppuccin";
        rev = "be4725cfc3fb6ed96f706d9d1bd5baa24d2b048c";
        hash = "sha256-Z3ZfpmMrnKugOhu8cuGZGMM8hVy0GpaOfuGNyQBkGdY=";
      };
    in
    "${src}/";
  home.file.".vimrc".source = ./dotfiles/.vimrc;

  home.shellAliases = {
    cd = "z";
    rm = "rm -i";
    srm = "srm -i";
    ls = "eza";
    ll = "eza -l";
    "..." = "cd ../..";
    top = "btop -p 0";
    btop = "btop -p 0";
    df = "duf";
    todo = "todo.sh -d ~/.config/todo-cli.conf -T -A -n";
    restartwm = "gnome-extensions reset paperwm@paperwm.github.com; gnome-extensions enable paperwm@paperwm.github.com";
  };

  home.packages = with pkgs; [
    zoxide
    eza
    duf
    srm
    btop
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
