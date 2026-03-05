# Allows for loading/unloading environment variables depending on the current directory
{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = {
    lib,
    ...
  }: {
    programs.direnv = {
      enable = lib.mkDefault true;
      nix-direnv.enable = lib.mkDefault true;
    };
  };
}