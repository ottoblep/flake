# Manage file synchronization
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rclone
    rclone-browser
  ];
}