# Imports Home-Manager for NixOS
{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.nh = {
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