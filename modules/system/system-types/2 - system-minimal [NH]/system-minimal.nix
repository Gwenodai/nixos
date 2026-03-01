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
      locale
      firmware
      ssh
      xdg
      sops-nix
    ];
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.system-minimal = {
    imports = with inputs.self.modules.homeManager; [
      system-config
      
      git
      xdg
      sops-nix
    ];
  };
}