# Imports Disko for NixOS
{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.disko = {
    imports = [
      inputs.disko.nixosModules.disko
    ];
  };
}