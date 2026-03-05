{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = {
    options,
    config,
    lib,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation.ignore = {
        directories = [
          "${config.xdg.cacheHome}/bat"
        ];
        files = [
          "${config.xdg.stateHome}/lesshst"
        ];
      };
    };
  };
}