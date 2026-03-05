# Garbage collection config
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.garbage-collection = {
    lib,
    ...
  }: {
    nix.gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 30d";
    };
    # Hard link identical files to save space
    nix.settings.auto-optimise-store = lib.mkDefault true;
  };
}