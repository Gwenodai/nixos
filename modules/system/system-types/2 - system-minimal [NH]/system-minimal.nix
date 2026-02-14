# Essentials for a minimal functioning system
{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.system-minimal = {
    imports = with inputs.self.modules.nixos; [
      system-config
      
      kernel-default
      disko
      home-manager
      garbage-collection
      # TODO: Implement:
      # secrets
    ];
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.system-minimal = {
    imports = with inputs.self.modules.homeManager; [
      system-config
      
      # TODO: Implement:
      # secrets
    ];
  };
}