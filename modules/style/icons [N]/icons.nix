{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.icons = {
    pkgs,
    ...
  }: {
    # environment.systemPackages = with pkgs; [
    #   
    # ];
  };
}