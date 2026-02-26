# A modern replacement for 'ls'
{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = {
    lib,
    ...
  }: {
    programs.eza = {
      enable = true;
      enableBashIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      icons = lib.mkDefault "always";
      git = lib.mkDefault true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
  };
}