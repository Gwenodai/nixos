{
  inputs,
  ...
}:

{
  # Expansion of system-cli for desktop use

  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli
      # TODO: Implement:
      # printing
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      # TODO: Implement:
      # browser
    ];
  };
}