{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.lact = {
    ...
  }: {
    services = {
      lact = {
        enable = true;
      };
    };
  };
}