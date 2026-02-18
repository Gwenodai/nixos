{
  self,
  lib,
  ...
}: let
  username = "gwen";
in {
  # Merge generated user output from `user` factory with manual input
  flake.modules = lib.mkMerge [ #        `flake.modules`─►──┬─►───────────────────────────────╮
    # Factory generated `<class>.gwen`  +`nixos.gwen`─►─────┴─►─╮   +`homeManager.gwen`─►─────┴─►─╮
    (self.factory.user username true) # =`flake.modules.nixos.gwen` =`flake.modules.homeManager.gwen`
    # Manual class declaration
    {
      # --- NIXOS MODULE ---
      nixos."${username}" = { # Equates to `flake.modules`.`nixos.gwen`
        # imports = with self.modules.nixos; [
        #   Define nixos modules to load here
        # ];
        users.users."${username}" = {
          # hashedPasswordFile = "/persist/secrets/passwords/${username}";
          initialPassword = "changeme";
        };
      };

      # --- HOME MANAGER MODULE ---
      homeManager."${username}" = { # Equates to `flake.modules`.`homeManager.gwen`
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