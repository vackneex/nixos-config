{ ... }: {

  flake.nixosModules.shared-disko-config = { ... }: {
    disko.devices = {
      disk.main = {
        device = "/dev/disk/by-id/ata-SAMSUNG_MZNLF128HCHP-00004_S2DNNXAH219864";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}