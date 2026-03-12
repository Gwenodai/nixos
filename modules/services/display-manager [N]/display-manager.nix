# TODO: configure ly
# https://github.com/fairyglade/ly
# https://github.com/fairyglade/ly/blob/master/res/config.ini
{ den, ... }: {
  den.aspects.display-manager = {
    includes = with den.aspects.display-manager.provides; [
      ly
    ];

    provides.ly = { host, user, ... }: {
      nixos = { lib, ... }: {
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
              # animation = "";
            };
          };
        };
      };

      persist.files = [
        { file = "/etc/ly/save.txt"; mode = "0644"; }
      ];
      persistUserIgnore.directories = [ "ly-session.log" ];
    };
  };
}
