{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.fonts = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      # Import the Home Manager module automatically
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.fonts
      ];
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.fonts = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        ignore.directories = [
          "${config.xdg.cacheHome}/fontconfig"
        ];
      };
    };
  };
}