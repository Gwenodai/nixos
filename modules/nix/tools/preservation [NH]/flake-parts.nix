{
  inputs,
  ...
}: {
  flake.modules.nixos.preservation = { ... }: {
    imports = [
      inputs.preservation.nixosModules.preservation
    ];
  };
}