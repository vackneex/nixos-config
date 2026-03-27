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
      };

      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    };
  };
}