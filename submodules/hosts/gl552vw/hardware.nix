{ ... }: {

  flake.nixosModules.gl552vw-config-hardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd = { 
        availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc"];
        kernelModules = [];
      };

      kernelParams = [ "quiet" "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
      kernelModules = ["kvm-intel"];
      extraModulePackages = [];
      consoleLogLevel = 3;

      loader = { 
        limine = {
          enable = true;
          secureBoot.enable = true;
          maxGenerations = 5;

          style = {
            wallpapers = [ ../../../assets/bootloader-wallpaper.png ];
          };
        };

        efi.canTouchEfiVariables = true;
        timeout = 5;
      };

      plymouth = {
        enable = true;
        theme = "pixels";

        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["pixels"];
          })
        ];
      };
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

    hardware = {
      cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
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

      bluetooth.enable = true;
    };

    services = {
      xserver.videoDrivers = [ "nvidia" ];
      timesyncd.enable = true; # My CMOS died temporarily so this may help
    };

    networking.timeServers = [ "0.nixos.pool.ntp.org" "1.nixos.pool.ntp.org" ];
  };
}
