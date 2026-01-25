{
  inputs,
  ...
}: {
  flake.modules.nixos.niri = { ... }: {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
  };

  flake.modules.homeManager.niri = { ... }: {
    imports = [
      inputs.niri.homeModules.niri
      inputs.niri.homeModules.config
    ];
    programs.niri.enable = true;
  };
}
