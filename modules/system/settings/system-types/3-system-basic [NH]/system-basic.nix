{
  inputs,
  ...
}:

{
  # Basic system with ssh

  flake.modules.nixos.system-basic = {
    imports = with inputs.self.modules.nixos; [
      system-essential
      # ssh
      # TODO: Implement SSH service
    ];
  };

  flake.modules.homeManager.system-basic = {
    imports = with inputs.self.modules.homeManager; [
      system-essential
    ];
  };
}