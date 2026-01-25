{
  flake.modules.homeManager.swaync = { pkgs, ... }: {
    services.swaync.enable = true;
  };
}
