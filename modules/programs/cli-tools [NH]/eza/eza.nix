# A modern replacement for 'ls'
{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = {
    ...
  }: {
    programs.eza = inputs.self.lib.applyDefaults {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      icons = "always";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
  };
}