{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.messenger = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${config.xdg.configHome}/Caprine";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
          ];
        };

        setupDirectories = {
          "${config.xdg.configHome}" = { }; # "~/.config"
        };
      };
    };
  };
}