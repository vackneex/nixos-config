{ inputs, self, ... }: {

  flake.nixosModules.shared-host-config = { config, lib, pkgs, ... }:
  let
    cfg = config.host-system;
  in {
    options.host-system = {
      hostname = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
      };
    };

    config = {
      boot.kernelPackages = pkgs.linuxPackages_zen;
      networking.networkmanager.enable = true;
      networking.hostName = cfg.hostname;

      nixpkgs.overlays = [ inputs.nur.overlays.default ];
      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Warsaw";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      services.desktopManager.plasma6.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
      };
      services.printing.enable = true;

      services.earlyoom = {
        enable = true;
        freeSwapThreshold = 2;
        freeMemThreshold = 2;
        extraArgs = [
            "-g"
            "--avoid" "^(X|plasma.*|konsole|kwin)$"
            "--prefer" "^(electron|libreoffice|gimp)$"
        ];
      };

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      virtualisation = {
        containers.enable = true;

        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      users.users.vknx = {
        isNormalUser = true;
        description = "vackneex";
        shell = pkgs.fish;
        extraGroups = ["networkmanager" "wheel"];
      };
      programs.fish.enable = true;

      environment.systemPackages = with pkgs; [
        wget
        git
        fastfetch
        p7zip
        btop
        sbctl
        protonup-ng
        mangohud
        dive
        podman-tui
        podman-compose
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.lilex
        google-fonts
      ];

      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      programs.gamemode.enable = true;

      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-qt;
      };

      services.openssh.enable = true;

      nix.settings.experimental-features = ["nix-command" "flakes"];
      system.stateVersion = "25.11";
    };
  };
}