{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.gwen = {
    lib,
    config,
    ...
  }: {
    config = lib.mkIf ( config.programs.git.enable or false ) {
      sops = {
        # Initialise secrets
        secrets = {
          "git/name" = {};
          "git/email" = {};
        };
        
        # Construct git `user` config from secrets
        templates."git-credentials" = {
          content = ''
            [user]
              name = "${config.sops.placeholder."git/name"}"
              email = "${config.sops.placeholder."git/email"}"
          '';
        };
      };

      programs.git = {
        includes = [
          { path = config.sops.templates."git-credentials".path; }
        ];
      };
    };
  };
}