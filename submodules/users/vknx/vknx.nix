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
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    home.packages = with pkgs; [
      kdePackages.kate
      kdePackages.ktorrent
      kdePackages.filelight
      kdePackages.kolourpaint
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
      ardour
      tetrio-desktop
    ];
  };
}