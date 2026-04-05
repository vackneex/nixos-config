{ inputs, self, lib, ... }: {

  flake.nixosConfigurations.asus-gl552vw = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.shared-host-config
      self.nixosModules.asus-gl552vw-config-hardware
      self.nixosModules.home-manager

      inputs.disko.nixosModules.disko
      self.nixosModules.shared-disko-config
      { 
        host-system.os-disk = "/dev/disk/by-id/ata-SAMSUNG_MZNLF128HCHP-00004_S2DNNXAH219864";
        host-system.hostname = "asus-gl552vw";
      }
    ];
  };
}