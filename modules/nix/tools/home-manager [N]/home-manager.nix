# Imports Home-Manager for NixOS
{
  inputs,
  config,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    # Define default settings for Home Manager
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";
    };
  };
}