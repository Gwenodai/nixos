{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.keyring = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${config.xdg.dataHome}/keyrings";
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