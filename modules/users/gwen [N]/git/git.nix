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
      programs.git.settings = {
        user = {
          name = "Gwenodai";
          email = "gwenpark37@gmail.com";
        };
      };
    };
  };
}