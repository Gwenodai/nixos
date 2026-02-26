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
        users.users."${username}" = {
          # hashedPasswordFile = "/persist/secrets/passwords/${username}";
          initialPassword = "changeme";
        };
      };
    }
  ];
}