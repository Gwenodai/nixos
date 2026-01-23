{
  inputs,
  ...
}: {
  flake.modules.nixos.gwen-t1 = {
    imports = with inputs.self.modules.nixos; [
      systemd-boot
      system-desktop
    ];
    preservation.enable = true;
  };
}