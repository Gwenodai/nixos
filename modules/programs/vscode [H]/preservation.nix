{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      preservation = {
        preserveAt."/persist" = {
          directories = [
            ".config/Code/User"
          ];
          files = [
            { file = ".config/Code/Trust Tokens"; mode = "0600"; }
            { file = ".config/Code/Trust Tokens-journal"; mode = "0600"; }
          ];
        };
        
        setupDirectories = {
          ".config" = { };
          ".config/Code" = { };
        };
      };
    };
  };
}