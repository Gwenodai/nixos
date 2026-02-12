{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.gwen = {
    lib,
    config,
    ...
  }: {
    programs.git = lib.mkIf config.programs.git.enable {
      settings = {
        user = {
          name = "Gwenodai";
          email = "gwenpark37@gmail.com";
        };
      };
    };
  };
}