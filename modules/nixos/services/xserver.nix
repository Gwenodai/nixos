{ pkgs, ... }:

{
  services.xserver = {
    enable = false; # Enable the X11 windowing system.
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}