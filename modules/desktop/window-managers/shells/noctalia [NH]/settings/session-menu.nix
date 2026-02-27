{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    ...
  }: {
    programs.noctalia-shell.settings.sessionMenu = inputs.self.lib.applyDefaults {
      enableCountdown = true;
      countdownDuration = 10000;
      position = "center";
      showHeader = true;
      showKeybinds = true;
      largeButtonsStyle = true;
      largeButtonsLayout = "single-row";
      powerOptions = [
        {
          action = "lock";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "1";
        }
        {
          action = "suspend";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "2";
        }
        {
          action = "hibernate";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "3";
        }
        {
          action = "reboot";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "4";
        }
        {
          action = "logout";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "5";
        }
        {
          action = "shutdown";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "6";
        }
        {
          action = "rebootToUefi";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "7";
        }
      ];
    };
  };
}