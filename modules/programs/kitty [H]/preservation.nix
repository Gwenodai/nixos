{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.kitty = {
    options,
    config,
    lib,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      preservation.ignore = {
        directories = [
          "${config.xdg.cacheHome}/kitty"
        ];
      };
    };
  };
}