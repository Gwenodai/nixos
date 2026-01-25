{
  flake.modules.homeManager.kitty = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      settings = {
        font_size = "12.0";
        confirm_os_window_close = 0;
      };
    };
  };
}
