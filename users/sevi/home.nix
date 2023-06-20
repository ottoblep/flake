{ config, pkgs, lib, ... }:

{
  home.username = "sevi";
  home.homeDirectory = "/home/sevi";

  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  # TODO set theme and icons
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # TODO update dconf
  # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true;
      # `gnome-extensions list` for a list
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
        "dash-to-panel@jderose9.github.com"
        # "sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
      ];
      favorite-apps = [ "firefox.desktop" "code.desktop" "org.gnome.Terminal.desktop" "org.gnome.Nautilus.desktop" ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    # `gsettings get org.gnome.shell.extensions.user-theme name`
    "org/gnome/shell/extensions/user-theme" = {
      name = "palenight";
    };
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "Main" ];
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/shell/extensions/vitals" = {
      show-storage = false;
      show-voltage = true;
      show-memory = true;
      show-fan = true;
      show-temperature = true;
      show-processor = true;
      show-network = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://${./saturn.jpg}";
      picture-uri-dark = "file://${./saturn.jpg}";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${./saturn.jpg}";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
  };

  # TODO set correct extensions
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    # gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar
    fix-vscode
  ] ++ (if stdenv.isx86_64 then [
    # kicad
    chromium
  ]);

  # TODO set vscode config
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = {
      "workbench.colorTheme" = "Palenight Operator";
      "terminal.integrated.scrollback" = 10000;
      "terminal.integrated.fontFamily" = "Jetbrains Mono";
      "terminal.integrated.fontSize" = 16;
      "editor.fontFamily" = "Jetbrains Mono";
      "telemetry.telemetryLevel" = "off";
      "remote.SSH.useLocalServer" = false;
      "editor.fontSize" = 18;
      "editor.formatOnSave" = true;
    };
    extensions = with pkgs.vscode-extensions; [
      mhutchie.git-graph
      jnoortheen.nix-ide
      vscodevim.vim 
      GitHub.github-vscode-theme
      PKief.material-icon-theme
    ]
  };

  programs.zsh.enable = true;

  # TODO insert zsh ohmyzsh here

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
