{ den, ... }:
{
  den.aspects.display-manager._.ly = den.lib.perHost {
    nixos =
      { lib, ... }:
      {
        services.displayManager = {
          enable = lib.mkDefault true;
          ly = {
            enable = lib.mkDefault true;
            x11Support = lib.mkDefault false;
            settings = {
              save = lib.mkDefault true;
              load = lib.mkDefault true;
              numlock = lib.mkDefault true;
              # Input box active by default on startup
              default_input = lib.mkDefault "password";
              # Erase password input on failure
              clear_password = lib.mkDefault true;
            };
          };
        };
      };

    persist.files = [
      {
        file = "/etc/ly/save.txt";
        mode = "0644";
      }
    ];
    persistUserIgnore.files = [ "ly-session.log" ];
  };
}
