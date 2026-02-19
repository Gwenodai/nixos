{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.homeManager.xdg = {
    ...
  }: {
    xdg = {
      enable = true;
      mimeApps = {
        enable = true;
      };
    };
  };
}