{ den, ... }:
{
  den.aspects.greetd = den.lib.perHost {
    nixos =
      { pkgs, ... }:
      {
        services.greetd = {
          enable = true;
          settings.default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --sessions /run/current-system/sw/share/wayland-sessions";
            user = "greeter";
          };
        };
      };
  };
}
