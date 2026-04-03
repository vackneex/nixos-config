{ inputs, self, ... }: {

  flake.nixosModules.home-vknx = { pkgs, ... }: {
    imports = [
      inputs.plasma-manager.homeModules.plasma-manager
      (self.nixosModules.firefox-config // {_class = null;})
      (self.nixosModules.fish-config // {_class = null;})
      (self.nixosModules.plasma-config // {_class = null;})
      (self.nixosModules.vscode-config // {_class = null;})
    ];

    home.username = "vknx";
    home.homeDirectory = "/home/vknx";
    home.stateVersion = "25.11";

    home.sessionVariables = {
      GPG_TTY = "$(tty)";
    };

    home.packages = with pkgs; [
      kdePackages.kate
      haruna
      gh
      vscode
      nixd
      alejandra
      youtube-music
      telegram-desktop
      wineWow64Packages.stable
      winetricks
      inputs.affinity-nix.packages.x86_64-linux.v3
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      prismlauncher
      openjdk25
      vesktop
      direnv
      blastem
    ];
  };
}