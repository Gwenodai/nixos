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
          directories = [
            "${config.xdg.cacheHome}/noctalia"
            "${config.xdg.cacheHome}/noctalia-qs"
            {
              directory = "${config.xdg.cacheHome}/cliphist";
              mode = "0700";
            }
            {
              directory = "${config.xdg.configHome}/noctalia/colorschemes";
              how = "symlink";
              createLinkTarget = true;
            }
          ];
        };

        setupDirectories = {
          "${config.xdg.configHome}/noctalia" = { };
        };
      };
    };
  };
}