{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.hardware.probe-rs;
in
{
  options.hardware.probe-rs = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = lib.mkDoc "Add udev permissions for various probes.";
    };
  };
  config = mkIf cfg.enable {
    services.udev.packages = [ (pkgs.callPackage ../pkgs/probe-rs-rules { }) ];
  };
}
