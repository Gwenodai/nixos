{
  pkgs,
  ...
}:

{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.vimix-cursors;
    name = "Vimix-cursors";
    size = 24;
  };
  xresources.properties = {
    "Xcursor.size" = 24;
  };
}