{ ... }: {

  flake.nixosModules.plasma-config = { ... }: {
    programs.plasma = {
      enable = true;
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
      };

      input = {
        keyboard = {
          layouts = [
            { 
              layout = "ru";
            }
            {
              layout = "ua";
            }
            {
              layout = "pl";
            }
          ];
          numlockOnStartup = "on";
          options = [
            "grp:alt_shift_toggle"
          ];
        };
      };

      # desktop = {
      #   widgets = [];
      # };
    };
  };
}