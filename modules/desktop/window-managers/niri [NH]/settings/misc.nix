{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.niri = {
    config,
    lib,
    ...
  }: {
    programs.niri = {
      settings = {
        screenshot-path = lib.mkDefault "${config.xdg.userDirs.pictures}/Screenshots/%Y-%m-%d %H-%M-%S.png";
      };
    };
  };
}
