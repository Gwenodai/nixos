{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.audio = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      # Import the Home Manager module automatically
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.audio
      ];
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.audio = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = "${config.xdg.stateHome}/wireplumber";
              mode = "0700";
            }
          ];
        };

        setupDirectories = {
          "${config.xdg.stateHome}" = { }; # "~/.local/state"
          ".local" = { };
        };
      };
    };
  };
}