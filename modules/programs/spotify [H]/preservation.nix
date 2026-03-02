{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.spotify = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${config.xdg.configHome}/spotify";
              how = "symlink";
              mode = "0755";
              createLinkTarget = true;
            }
            {
              directory = "${config.xdg.cacheHome}/spotify";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
          ];
        };
      };
    };
  };
}