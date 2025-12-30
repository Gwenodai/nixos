{
  inputs,
  ...
}:

{
  flake.modules.nixos.gwen-t1 = {
    imports = with inputs.self.modules.nixos; [
      grub-boot
      # TODO: Define nix modules to load here
      # ex: system-cli
    ];
  };
}