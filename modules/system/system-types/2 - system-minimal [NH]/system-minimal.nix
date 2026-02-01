# Essentials for a minimal functioning system
{
  inputs,
  ...
}: {
  flake.modules.nixos.system-minimal = {
    imports = with inputs.self.modules.nixos; [
      system-config

      home-manager
      garbage-collection
      # TODO: Implement:
      # secrets
    ];
  };

  flake.modules.homeManager.system-minimal = {
    imports = with inputs.self.modules.homeManager; [
      system-config
      
      # TODO: Implement:
      # secrets
    ];
  };
}