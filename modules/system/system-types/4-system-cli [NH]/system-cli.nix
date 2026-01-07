{
  inputs,
  ...
}:

{
  # Expansion of system-basic with cli-tools

  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-basic
      # TODO: Implement:
      # cli-tools
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-basic
      # TODO: Implement:
      # shell
    ];
  };
}