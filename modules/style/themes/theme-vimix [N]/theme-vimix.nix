{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.theme-vimix = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      vimix-cursors
      vimix-icon-theme
      vimix-gtk-themes
    ];
  };
}