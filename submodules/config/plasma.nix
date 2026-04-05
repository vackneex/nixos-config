{ ... }: {

  flake.nixosModules.plasma-config = { ... }: {
    programs.plasma = {
      enable = true;
      workspace.lookAndFeel = "org.kde.breezedark.desktop";

      input.keyboard = {
        layouts = [
          { layout = "pl"; }
          { layout = "ru"; }
          { layout = "ua"; }
        ];
        
        numlockOnStartup = "on";
        options = [
          "grp:alt_shift_toggle"
          "caps:backspace"
        ];
      };

      panels = [
        {
          alignment = "center";
          floating = true;
          hiding = "dodgewindows";
          lengthMode = "fit";
          location = "right";

          widgets = [
            "org.kde.plasma.kickoff"
            "org.kde.plasma.icontasks"
          ];
        }
        {
          alignment = "center";
          lengthMode = "fill";
          location = "top";
          height = 26;

          widgets = [
            {
              applicationTitleBar = {
                layout = {
                  elements = [
                    "windowIcon"
                    "windowTitle"
                  ];

                  widgetMargins = 0;
                };

                windowTitle.undefinedWindowTitle = "No Focus";
              };
            }
            "org.kde.plasma.panelspacer"
            {
              digitalClock = {
                date.enable = false;
              };
            }
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.systemmonitor.diskusage"
            "org.kde.plasma.systemmonitor.cpu"
            "org.kde.plasma.systemmonitor.memory"
            {
              systemTray = {
                items.hidden = [
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.mediacontroller"
                ];
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
      ];
    };
  };
}