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
    ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fd" "zoxide" "ripgrep" ];
      theme = "gozilla";
    };
  };

  catppuccin = {
    flavour = "macchiato";
    accent = "mauve";
  };

  programs.neovim.catppuccin.enable = true;
  programs.btop.catppuccin.enable = true;

  home.file.".config/btop/btop.conf".source = ./dotfiles/btop.conf;
  home.file.".config/todo-cli.conf".source = ./dotfiles/todo-txt-cli.conf;

  home.shellAliases = {
    vim = "nvim";
    rm = "rm -i";
    srm = "srm -i";
    ll = "ls -l";
    ls = "ls --color=tty";
    "..." = "cd ../..";
    top = "btop -p 0";
    btop = "btop -p 0";
    df = "duf";
    todo = "todo.sh -d ~/.config/todo-cli.conf -T -A -n";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
