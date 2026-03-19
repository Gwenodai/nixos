{ inputs, den, ... }: {
  den.aspects.niri._.settings._.input = den.lib.perUser {
    homeManager = {
      programs.niri.settings.input = inputs.self.lib.applyDefaultsRecursive {
        keyboard = {
          xkb.layout = "us";
          numlock = true;
          repeat-delay = 250;
          repeat-rate = 35;
        };

        mouse = {
          accel-speed = 0.7;
          accel-profile = "flat";
          scroll-method = "no-scroll";
        };

        warp-mouse-to-focus = {
          enable = true;
        };

        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "20%";
        };

        power-key-handling.enable = false;
      };
    };
  };
}