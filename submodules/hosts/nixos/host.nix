{ inputs, self, lib, ... }: {

  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.shared-host-config
      self.nixosModules.nixos-hostname
      self.nixosModules.nixos-config-hardware
      self.nixosModules.home-manager

      inputs.disko.nixosModules.disko
      self.nixosModules.shared-disko-config
    ];
  };

  flake.nixosModules.nixos-hostname = { ... }: {
    networking.hostName = lib.mkForce "nixos";
  };
}