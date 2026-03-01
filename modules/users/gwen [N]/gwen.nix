{
  self,
  lib,
  ...
}: let
  username = "gwen";
in {
  # Merge generated user output from `user` factory with manual input
  flake.modules = lib.mkMerge [
    ( self.factory.user username true ) # returns `nixos.gwen` and `homeManager.gwen`
    {
      # --- NIXOS MODULE ---
      nixos."${username}" = { # Equates to `flake.modules.nixos.gwen`
        config,
        ...
      }: {
        sops.secrets.user-password.neededForUsers = true;

        users.users."${username}" = {
          # initialPassword = "changeme";
          hashedPasswordFile = config.sops.secrets.user-password.path;
        };
      };
    }
  ];
}