{ ... }: {

  flake.nixosModules.fish-config = { ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting ""
      '';
      shellAliases = {
        clean-user = "nix-collect-garbage -d";
        clean-system = "sudo nix-env --delete-generations +5 -p /nix/var/nix/profiles/system && sudo nix-collect-garbage -d";
      };
    };
  };
}