{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.graphics = {
    ...
  }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}