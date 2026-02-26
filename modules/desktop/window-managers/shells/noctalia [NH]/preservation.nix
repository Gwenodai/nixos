{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    options,
    config,
    lib,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [];
        };
        
        setupDirectories = {};

        ignore.directories = [
          "${config.xdg.cacheHome}/noctalia/images/contributors"
        ];
      };
    };
  };
}