{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.themes = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      vimix-gtk-themes
    ];
  };
}