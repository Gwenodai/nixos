{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.lact = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation.ignore.directories = [
        "/etc/lact"
      ];
    };
  };
}