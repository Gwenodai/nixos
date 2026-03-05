{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.discord = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${config.xdg.configHome}/vesktop/sessionData";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
          ];
          files = [
            { file = "${config.xdg.configHome}/vesktop/Crashpad/client_id"; mode = "0644"; }
            { file = "${config.xdg.configHome}/vesktop/state.json"; mode = "0644"; }
          ];
        };

        setupDirectories = {
          "${config.xdg.configHome}" = { }; # "~/.config"
          "${config.xdg.configHome}/vesktop" = { };
          "${config.xdg.configHome}/vesktop/Crashpad" = { mode = "0700"; };
          "${config.xdg.configHome}/vesktop/sessionData" = { mode = "0700"; };
        };

        ignore = {
          files = [
            "${config.xdg.configHome}/vesktop/settings/quickCss.css"
          ];
        };
      };
    };
  };
}