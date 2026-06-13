{
  den.aspects.ly = {
    nixos = {
      services.displayManager = {
        enable = true;
        ly = {
          enable = true;
          x11Support = false;
          settings = {
            save = true;
            load = true;
            numlock = true;
            # Input box active by default on startup
            default_input = "password";
            # Erase password input on failure
            clear_password = true;
          };
        };
      };
    };

    ### Persist config
    persist = {
      files = [
        {
          file = "/etc/ly/save.txt";
          mode = "0644";
        }
      ];
    };

    persistUserIgnore = {
      files = [
        # "~/ly-session.log"
        "ly-session.log"
      ];
    };
  };
}
