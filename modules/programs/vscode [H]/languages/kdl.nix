{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    vscode-marketplace,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          nix-embedded-languages.include = {
            kdl = "source.kdl";
          };
        };

        extensions = with vscode-marketplace; [
          kdl-org.kdl
        ];
      };
    };
  };
}