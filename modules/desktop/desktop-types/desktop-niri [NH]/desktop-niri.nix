# Expansion of system-desktop using Niri/Noctalia
{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.desktop-niri = {
    imports = with inputs.self.modules.nixos; [
      system-desktop

      ly
      niri
      noctalia
    ];
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.desktop-niri = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop

      niri
      noctalia
    ];
  };
}