{ ... }: {

  flake.nixosModules.firefox-config = {pkgs, ...}: {
    programs.firefox = {
      enable = true;
      profiles.main = {
        isDefault = true;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          darkreader
          sponsorblock
          youtube-recommended-videos
          istilldontcareaboutcookies
        ];
      };

      policies = {
        PasswordManagerEnabled = false;
        DisableFirefoxAccounts = true;
        GenerativeAI = {
          Enabled = false;
          Chatbot = false;
          Locked = true;
        };
        Homepage.StartPage = "previous-session";
        SearchEngines.Default = "DuckDuckGo";

        ExtensionsSettings = {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = { # Bitwarden
            global_autofillSettingsLocal_inlineMenuVisibility = ''{"__json__": true, "value": "2"}'';
          };
        };
      };

      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    };
  };
}