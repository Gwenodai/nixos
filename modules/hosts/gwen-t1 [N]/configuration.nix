# Host system config
{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    imports = with inputs.self.modules.nixos; [
      systemd-boot
      system-desktop
      preservation
      it87 # Custom it87 driver for MB sensors
    ];
  };
}