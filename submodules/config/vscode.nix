{ ... }: {

  flake.nixosModules.vscode-config = { osConfig, pkgs, ... }: {
    programs.vscode = {
      enable = true;
      profiles.default = {
        enableUpdateCheck = false;

        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          oops418.nix-env-picker
          llvm-vs-code-extensions.vscode-clangd
          ms-vscode.cmake-tools
          twxs.cmake
          mkhl.direnv
          redhat.java
        ];

        userSettings = {
          "workbench.secondarySideBar.defaultVisibility" = "hidden";
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings" = {

            "nixd" = {
              "formatting" = {
                "command" = ["alejandra"];
              };

              "nixpkgs" = {
                "expr" = "import <nixpkgs> { }";
              };

              "options" = {
                "nixos" = {
                  "expr" = "(builtins.getFlake \"\${workspaceFolder}\").nixosConfigurations.asus-gl552vw.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake \"\${workspaceFolder}\").nixosConfigurations.asus-gl552vw.options.home-manager.users.value.vknx";
                };
              };
            };
          };
          "git.autofetch" = true;
          "git.enableSmartCommit" = true;
          "workbench.settings.showAISearchToggle" = false;
          "nixEnvSelector.useFlakes" = true;
          "cmake.generator" = "Ninja";
        };
      };
    };
  };
}