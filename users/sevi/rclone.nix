# Manage file synchronization
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rclone
    rclone-browser
  ];

  # Home-Manager service settings correspond to the original systemd config file closely while the default nixos service module is more abstracted
  # https://mynixos.com/home-manager/option/systemd.user.services
  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=user.services

  systemd.user.services."rclone-bisync" = {
    Service = {
      Type = "oneshot";
      # Initial setup:
      # - Insert config manually 
      # - rclone bisync --resync gdrive-crypt:/ /home/sevi/sync
      ExecStart = "${pkgs.rclone}/bin/rclone bisync --check-access -v /home/sevi/sync gdrive-crypt:/";
    };
  };

  systemd.user.timers."rclone-bisync" = {
    Install.WantedBy = [ "timers.target" ];
    Unit.PartOf = "rclone-bisync.service";
    Timer = {
      OnCalendar = "minutely";
      Unit = "rclone-bisync.service";
    };
  };

  systemd.user.services."rclone-local-backup" = {
    Service = {
      Type = "oneshot";
      WorkingDirectory = "/home/sevi";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '${pkgs.gnutar}/bin/tar --zstd -cf /home/sevi/sync-$(date -I).tar.zst /home/sevi/sync'
      '';
    };
  };

  systemd.user.timers."rclone-local-backup" = {
    Install.WantedBy = [ "timers.target" ];
    Unit.PartOf = "rclone-local-backup.service";
    Timer = {
      OnCalendar = "weekly";
      Persistent = true; 
      Unit = "rclone-local-backup.service";
    };
  };
}