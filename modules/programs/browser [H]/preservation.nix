{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.browser = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = ".config/google-chrome";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
            { # TODO: Move keyrings persistence to a separate module
              directory = ".local/share/keyrings";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
          ];
        };
        
        setupDirectories = {
          ".config" = { };
          ".local" = { };
          ".local/share" = { };
        };
      };
    };
  };
}