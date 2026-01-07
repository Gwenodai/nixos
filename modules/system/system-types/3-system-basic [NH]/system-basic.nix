{
  inputs,
  ...
}:

{
  # Basic system with ssh

  flake.modules.nixos.system-basic = {
    imports = with inputs.self.modules.nixos; [
      system-essential
      # TODO: Implement:
      # ssh
    ];
  };

  flake.modules.homeManager.system-basic = {
    imports = with inputs.self.modules.homeManager; [
      system-essential
    ];
  };
}