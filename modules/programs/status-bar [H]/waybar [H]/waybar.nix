{
  flake.modules.homeManager.waybar = { pkgs, ... }: {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
