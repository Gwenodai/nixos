{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = {
    config,
    lib,
    ...
  }: {

    programs.nh = {
      enable = true;
      clean = lib.mkDefault {
        enable = true;
        extraArgs = "--keep-since 30d --keep 3";
      };
      flake = lib.mkDefault "${config.home.homeDirectory}/dots";
    };
  };
}