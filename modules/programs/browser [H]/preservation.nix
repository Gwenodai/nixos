{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.browser = {
    options,
    config,
    lib,
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
            { # TODO: Move keyrings persistence to a separate module
              directory = "${config.xdg.dataHome}/keyrings";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
          ];
        };
        
        setupDirectories = {
          "${config.xdg.configHome}" = { }; # "~/.config"
          ".local" = { };
          "${config.xdg.dataHome}" = { }; # "~/.local/share"
        };

        ignore.directories = [
          "${config.xdg.cacheHome}/google-chrome"
        ];
      };
    };
  };
}