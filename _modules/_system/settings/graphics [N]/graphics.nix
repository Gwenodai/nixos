{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.graphics = {
    lib,
    ...
  }: {
    hardware.graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };
  };
}