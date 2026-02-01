# Expansion of system-minimal with full cli toolset
{
  inputs,
  ...
}: {
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-minimal

      ssh
      locale
      firmware
      cli-tools
      sys-tools
      archive-tools
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-minimal

      cli-tools
      sys-tools
      shell
      git
    ];
  };
}