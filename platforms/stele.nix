{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    let
      user-image = ./icons/stele.jpg;
      tflight4 = pkgs.linuxPackages.callPackage ../pkgs/tflight4 { };
    in
    {
      networking.hostName = "stele";

      # Set profile images
      system.activationScripts.setUserImages.text = ''
        cp -f ${user-image} /var/lib/AccountsService/icons/sevi
      '';

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "hid-tflight4"];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ tflight4 ];
  boot.extraModprobeConfig = ''options hid-tflight4 throttle_seesaw_extra_axis=1'';

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
        videoAcceleration = true;
        open = true;
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
    };
}
