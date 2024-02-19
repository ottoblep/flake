{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    {
      networking.hostName = "stele";

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      # RTX 2060
      services.xserver.videoDrivers = [ "nvidia" ];

      # Enable OpenGL
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        powerManagement.enable = true;
        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = true;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of 
        # supported GPUs is at: 
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = true;

        # Enable the Nvidia settings menu,
	      # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };

      fileSystems."/" =
        {
          device = "/dev/disk/by-label/nixos";
          fsType = "ext4";
        };

      fileSystems."/storage" =
        {
          device = "/dev/disk/by-label/storage";
          fsType = "ext4";
        };

      fileSystems."/boot" =
        {
          device = "/dev/disk/by-label/boot";
          fsType = "vfat";
        };

      nixpkgs.overlays = [
        (final: prev: { })
      ];
    };
}
