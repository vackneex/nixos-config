{ inputs, self, ... }: {

  flake.nixosModules.home-manager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
  
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.vknx = (self.nixosModules.home-vknx // {_class = null;});
      backupFileExtension = "bak";
      extraSpecialArgs = { inherit inputs; };
    };
  };
}