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
    config = inputs.self.lib.mkIfNiri { inherit options; } {
      programs.niri.settings = {
        layer-rules = [
          { # Render walpaper in backdrop for overview mode
            matches = [ { namespace = "^noctalia-overview*"; } ];
            place-within-backdrop = true;
          }
        ];
      };
    };
  };
}
