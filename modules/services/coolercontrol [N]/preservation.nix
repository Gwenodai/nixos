{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.coolercontrol = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      preservation.ignore = {
        directories = [
          "/etc/coolercontrol"
        ];
      };
    };
  };
}