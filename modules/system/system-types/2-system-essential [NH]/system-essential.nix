{
  inputs,
  ...
}: {
  # Import all essentials which which are used in all modules
  flake.modules.nixos.system-essential = {
    imports = with inputs.self.modules.nixos; [
      system-default
      home-manager
      garbage-collection
      # TODO: Implement:
      # impermanence
      # secrets
    ];
  };

  flake.modules.homeManager.system-essential = {
    imports = with inputs.self.modules.homeManager; [
      system-default
      # TODO: Implement:
      # impermanence
      # secrets
    ];
  };
}