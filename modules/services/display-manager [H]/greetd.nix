{ den, ... }:
{
  den.aspects.display-manager._.greetd = den.lib.perHost {
    nixos =
      { pkgs, lib, ... }:
      {
        services.greetd = {
          enable = lib.mkDefault true;
          settings.default_session = {
            command = lib.mkDefault "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --sessions /run/current-system/sw/share/wayland-sessions";
            user = lib.mkDefault "greeter";
          };
        };
      };
  };
}
