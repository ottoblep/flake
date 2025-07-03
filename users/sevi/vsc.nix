{ pkgs, ... }:

{
  # Build tools and libraries can be defined in separate devshells
  # Open vscode inside a dev shell to inherit env (direnv)

  programs.direnv.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode.fhsWithPackages (ps: with ps; [ ]);
    extensions = with pkgs.unstable.vscode-extensions; [
      # General
      mhutchie.git-graph
      vscodevim.vim
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      mechatroner.rainbow-csv
      # Nix
      jnoortheen.nix-ide
      mkhl.direnv
      # Docs
      ms-vscode-remote.remote-containers
      # Latex
      # james-yu.latex-workshop

      # Not in nixpkgs
      # letmaik.git-tree-compare
      # nowsci.glassit-linux
    ];

    keybindings = [
      {
        key = "ctrl+alt+[Backslash]"; # ctrl + alt + #
        command = "workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "alt+q";
        command = "workbench.action.closeActiveEditor";
      }
      {
        key = "ctrl+shift+[Backslash]"; # ctrl + shift + #
        command = "workbench.action.closeSidebar";
      }
      {
        key = "ctrl+alt+p";
        command = "workbench.action.quickOpen";
      }
      {
        key = "ctrl+shift+e";
        command = "-workbench.action.quickOpenNavigatePreviousInFilePicker";
      }
      {
        key = "ctrl+shift+q";
        command = "workbench.view.extension.gitTreeCompare";
      }
      {
        key = "ctrl+shift+t";
        command = "workbench.view.extension.test";
      }
      {
        key = "ctrl+shift+t";
        command = "-workbench.action.reopenClosedEditor";
      }
      {
        key = "ctrl+shift+[BracketLeft]";
        command = "search.action.focusPreviousSearchResult";
      }
      {
        key = "ctrl+shift+[Quote]";
        command = "search.action.focusNextSearchResult";
      }
      {
        key = "ctrl+u";
        command = "workbench.action.terminal.scrollUpPage";
        when = "terminalFocusInAny && terminalHasBeenCreated && !terminalAltBufferActive || terminalFocusInAny && terminalProcessSupported && !terminalAltBufferActive";
      }
      {
        key = "ctrl+d";
        command = "workbench.action.terminal.scrollDownPage";
        when = "terminalFocusInAny && terminalHasBeenCreated && !terminalAltBufferActive || terminalFocusInAny && terminalProcessSupported && !terminalAltBufferActive";
      }
      {
        key = "ctrl+shift+w";
        command = "-workbench.action.closeWindow";
      }
      # ctrl+tab to switch tabs 
      # ctrl + 1234 to switch panes
      # ctrl + shift + EFGQ for sidebar opening
      # ctrl + shift + q for tree diff 
      # ctrl + shift + t for tests 
      # ctrl + alt + p to open files
      # ctrl + shift + p for all vscode commands
      # ctrl + shift + ü/ä to navigate keyword search results
    ];

    userSettings = {
      "security.workspace.trust.untrustedFiles" = "open";
      "window.menuBarVisibility" = "toggle";
      "window.titleBarStyle" = "custom";
      "editor.fontSize" = 13;
      "editor.wordWrap" = "on";
      "terminal.integrated.fontSize" = 13;
      "vim.foldfix" = true;
      "vim.useSystemClipboard" = true;
      "editor.minimap.enabled" = false;
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.startupEditor" = "none";
      "workbench.activityBar.location" = "hidden";
      "glassit-linux.opacity" =  95;
      "latex-workshop.view.pdf.spreadMode" = 0; # For dual page
      "latex-workshop.view.pdf.color.dark.pageBorderColor" = "#181926"; # Catppuccin Macchiato
      "latex-workshop.view.pdf.color.dark.backgroundColor" = "#1e2030";
      "latex-workshop.view.pdf.color.dark.pageColorsBackground" = "#24273a";
      "latex-workshop.view.pdf.color.dark.pageColorsForeground" = "#cad3f5";
      "latex-workshop.latex.autoClean.run" = "onBuilt";
      "symbols.hidesExplorerArrows" = false;
    };
  };
}
