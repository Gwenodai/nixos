{ ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # Hard link identical files to save space
  nix.settings.auto-optimise-store = true;
}