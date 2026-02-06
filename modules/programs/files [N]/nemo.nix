{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.files = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      nemo # File browser for Cinnamon
    ];
  };
}