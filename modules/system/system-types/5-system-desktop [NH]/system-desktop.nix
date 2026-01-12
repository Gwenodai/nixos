{
  inputs,
  ...
}: {
  # Expansion of system-cli for desktop use
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      browser
    ];
  };
}