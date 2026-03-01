{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${config.xdg.dataHome}/direnv/allow";
              how = "symlink";
              createLinkTarget = true;
            }
          ];
        };
        
        setupDirectories = {
          "${config.xdg.dataHome}/direnv" = { };
        };
      };
    };
  };
}