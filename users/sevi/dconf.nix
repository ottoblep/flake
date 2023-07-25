# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };

    "org/gnome/desktop/interface" = {
      clock-show-seconds = false;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
      text-scaling-factor = 1.3;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      edge-scrolling-enabled = false;
      speed = -7.027027027027022e-2;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ ];
      begin-move = [ ];
      begin-resize = [ ];
      cycle-panels = [ ];
      cycle-panels-backward = [ ];
      maximize = [ ];
      minimize = [ ];
      move-to-monitor-down = [ ];
      move-to-monitor-left = [ ];
      move-to-monitor-right = [ ];
      move-to-monitor-up = [ ];
      move-to-workspace-1 = [ ];
      move-to-workspace-last = [ ];
      move-to-workspace-left = [ ];
      move-to-workspace-right = [ ];
      panel-run-dialog = [ ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-panels = [ ];
      switch-panels-backward = [ ];
      switch-to-workspace-1 = [ ];
      switch-to-workspace-last = [ ];
      switch-to-workspace-left = [ ];
      switch-to-workspace-right = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      toggle-fullscreen = [ "<Super>d" ];
      toggle-maximized = [ ];
      unmaximize = [ ];
    };

    "org/gnome/eog/ui" = {
      sidebar = false;
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "small";
    };

    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "medium";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 945 1193 ];
      maximized = false;
      sidebar-width = 204;
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = true;
      dual-page-odd-left = true;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = false;
      sidebar-page = "thumbnails";
      sidebar-size = 246;
      sizing-mode = "automatic";
      window-ratio = mkTuple [ 1.9833333333333334 1.987037037037037 ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>plus";
      command = "alacritty";
      name = "Launch Shell";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ ];
      enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "BingWallpaper@ineffable-gmail.com" "dash-to-dock@micxgx.gmail.com" "transparent-top-bar@ftpix.com" "paperwm@hedning:matrix.org" "paperwm@paperwm-redux.github.com" ];
      favorite-apps = [ 
        "chromium-browser.desktop"
        "code.desktop"
        "thunderbird.desktop"
        "org.gnome.Nautilus.desktop"
        "org.keepassxc.KeePassXC.desktop"
        "org.speedcrunch.SpeedCrunch.desktop" 
        ];
    };

    "org/gnome/shell/extensions/bingwallpaper" = {
      delete-previous = true;
      download-folder = "/home/sevi/Pictures/BingWallpaper/";
      icon-name = "bing-symbolic";
      lockscreen-blur-brightness = 60;
      lockscreen-blur-strength = 2;
      override-lockscreen-blur = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      animate-show-apps = true;
      apply-custom-theme = false;
      background-color = "rgb(0,0,0)";
      background-opacity = 0.0;
      custom-background-color = true;
      custom-theme-shrink = false;
      dash-max-icon-size = 58;
      disable-overview-on-startup = false;
      dock-position = "BOTTOM";
      height-fraction = 1.0;
      icon-size-fixed = true;
      isolate-monitors = true;
      isolate-workspaces = true;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP";
      preview-size-scale = 0.0;
      running-indicator-style = "DASHES";
      show-favorites = true;
      show-show-apps-button = true;
      show-trash = false;
      show-windows-preview = true;
      transparency-mode = "FIXED";
      workspace-agnostic-urgent-windows = true;
    };

    "org/gnome/shell/extensions/hibernate-status-button" = {
      hibernate-works-check = false;
    };

    "org/gnome/shell/extensions/hidetopbar" = {
      mouse-sensitive = true;
    };

    "org/gnome/shell/extensions/paperwm" = {
      has-installed-config-template = true;
      horizontal-margin = 8;
      minimap-scale = 0.0;
      show-window-position-bar = false;
      tiling-edge-margin = 3;
      topbar-follow-focus = false;
      use-default-background = true;
      vertical-margin = 3;
      vertical-margin-bottom = 3;
      window-gap = 8;
      winprops = [ ];
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      live-alt-tab = [ "" ];
      live-alt-tab-backward = [ "" ];
      move-down = [ "<Control><Super>j" ];
      move-left = [ "<Control><Super>h" ];
      move-monitor-above = [ "<Shift><Control><Super>k" ];
      move-monitor-below = [ "<Shift><Control><Super>j" ];
      move-monitor-left = [ "<Shift><Control><Super>h" ];
      move-monitor-right = [ "<Shift><Control><Super>l" ];
      move-right = [ "<Control><Super>l" ];
      move-up = [ "<Control><Super>k" ];
      switch-down = [ "<Super>j" ];
      switch-first = [ "" ];
      switch-last = [ "" ];
      switch-left = [ "<Super>h" ];
      switch-monitor-above = [ "<Shift><Super>k" ];
      switch-monitor-below = [ "<Shift><Super>j" ];
      switch-monitor-left = [ "<Shift><Super>h" ];
      switch-monitor-right = [ "<Shift><Super>l" ];
      switch-right = [ "<Super>l" ];
      switch-up = [ "<Super>k" ];
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ ];
      open-application-menu = [ ];
      toggle-application-view = [ ];
      toggle-message-tray = [ ];
      toggle-overview = [ ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "@av []";
    };

    "org/gnome/shell/world-clocks" = {
      locations = "@av []";
    };
  };
}
