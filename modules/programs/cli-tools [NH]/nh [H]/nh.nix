{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = {
    config,
    ...
  }: {

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 30d --keep 3";
      };
      flake = "${config.home.homeDirectory}/dots";
    };
  };
}