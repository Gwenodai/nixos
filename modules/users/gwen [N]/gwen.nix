{
  self,
  lib,
  ...
}: let
  username = "gwen";
in {
  # Merge generated user output from 'user' factory with manual input
  flake.modules = lib.mkMerge [
    # Factory generated user output
    (self.factory.user username true)
    # Manual input
    {
      # --- NIXOS MODULE ---
      nixos."${username}" = { # Equates to `flake.modules.nixos.gwen`
        # imports = with self.modules.nixos; [
          # Define nixos modules to load here
        # ];
        users.users."${username}" = {
          # hashedPasswordFile = "/persist/secrets/passwords/${username}";
          initialPassword = "changeme";
        };
      };

      # --- HOME MANAGER MODULE ---
      homeManager."${username}" = { # Equates to `flake.modules.homeManager.gwen`
        pkgs,
        ...
      }: {
        imports = with self.modules.homeManager; [
          system-desktop
        ];
        # home.packages = with pkgs; [
          # Define Home Manager pkgs to load here
        # ];
      };
    }
  ];
}