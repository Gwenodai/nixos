{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.cursors = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      vimix-cursors
    ];
  };
}