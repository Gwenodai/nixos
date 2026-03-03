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
        sops.secrets = {
          user-password.neededForUsers = true;
          "git/access-tokens/nixos-flake-updates" = {};
        };

        users.users."${username}" = {
          # initialPassword = "changeme";
          hashedPasswordFile = config.sops.secrets.user-password.path;
        };

        nix.extraOptions = ''
          !include ${config.sops.secrets."git/access-tokens/nixos-flake-updates".path}
        '';
      };
    }
  ];
}