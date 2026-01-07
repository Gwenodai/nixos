{
  inputs,
  ...
}:

{
  # Import all essential nix-tools which which are used in all modules of specific class

  flake.modules.nixos.system-essential = {
    imports = with inputs.self.modules.nixos; [
      system-default
      home-manager
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