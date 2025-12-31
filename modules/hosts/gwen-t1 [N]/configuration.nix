{
  inputs,
  ...
}:

{
  flake.modules.nixos.gwen-t1 = {
    imports = with inputs.self.modules.nixos; [
      grub-boot
    ];
  };
}