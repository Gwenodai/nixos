{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.niri = {
    ...
  }: {
    programs.niri = {
      settings = {
        environment = {
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          QT_QPA_PLATFORM = "wayland;xcb";
          GDK_BACKEND = "wayland,x11,*";
          XDG_CURRENT_DESKTOP = "niri";
          XDG_SESSION_TYPE = "wayland";
          XDG_SESSION_DESKTOP = "niri";
          NIXOS_OZONE_WL = "1";
          # QT_QPA_PLATFORMTHEME = "qt5ct";
        };
      };
    };
  };
}
