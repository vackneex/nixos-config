{ inputs, self, ...}: {

  flake.nixosModules.nixos-config-hardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc"];
    boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    boot.loader.limine = {
      enable = true;
      secureBoot = {
        enable = true;
      };
    };

    boot.loader.efi.canTouchEfiVariables = true;

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/9acae3c1-5e56-4b7c-84ef-f22a21aa284c";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/02FB-4D4F";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    fileSystems."/mnt/data" = {
      device = "/dev/disk/by-uuid/370b6e40-fd75-b9f6-7bf9-f17c6c1d5f8d";
      fsType = "btrfs";
      options = [
        "defaults"
        "nofail"
        "x-systemd.automount"
      ];
    };

    zramSwap.enable = true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    hardware.bluetooth.enable = true;

    services.timesyncd.enable = true; # My CMOS died temporarily so this may help
    networking.timeServers = [ "0.nixos.pool.ntp.org" "1.nixos.pool.ntp.org" ];

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}