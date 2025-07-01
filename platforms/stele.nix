{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    let
      user-image = ./icons/stele.jpg;
    in
    {
      networking.hostName = "stele";

      # Set profile images
      system.activationScripts.setUserImages.text = ''
        cp -f ${user-image} /var/lib/AccountsService/icons/sevi
      '';

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];

      hardware.graphics =
        let
          graphicsDrivers = with pkgs; [
            libva
            libvdpau
            libvdpau-va-gl
            nvidia-vaapi-driver
          ];
        in
        {
          enable = true;
          enable32Bit = true;
          extraPackages = graphicsDrivers;
          extraPackages32 = graphicsDrivers;
        };
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      hardware.openrazer.enable = true;
      hardware.openrazer.users = [ "sevi" ];
      environment.systemPackages = with pkgs; [
        openrazer-daemon
        polychromatic
        nvitop
        libva-utils
        vdpauinfo
        (unstable.llama-cpp.override { cudaSupport = true; cudaPackages = cudaPackages;})
      ];

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        powerManagement.enable = false;
        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of 
        # supported GPUs is at: 
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
        open = true;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      hardware.nvidia-container-toolkit.enable = true;

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

      boot.supportedFilesystems = [ "ntfs" ];

      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      nixpkgs.overlays = [
        (final: prev: { })
      ];
    };
}
