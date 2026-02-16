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
      preservation = let
        relativeToHome = path: lib.removePrefix (config.home.homeDirectory + "/") path;
      in {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${relativeToHome config.xdg.configHome}/google-chrome";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
            { # TODO: Move keyrings persistence to a separate module
              directory = "${relativeToHome config.xdg.dataHome}/keyrings";
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

        ignore = {
          directories = [
            "${config.xdg.cacheHome}/google-chrome"
          ];
        };
      };
    };
  };
}