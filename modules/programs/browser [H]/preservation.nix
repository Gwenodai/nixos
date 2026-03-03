{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.browser = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${config.xdg.configHome}/google-chrome";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
          ];
        };

        setupDirectories = {
          "${config.xdg.configHome}" = { }; # "~/.config"
        };

        ignore.directories = [
          "${config.xdg.cacheHome}/google-chrome"
        ];
      };
    };
  };
}