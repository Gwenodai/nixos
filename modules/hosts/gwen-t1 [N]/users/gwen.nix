{
  inputs,
  ...
}: {
  flake.modules.nixos.gwen-t1 = {
    imports = with inputs.self.modules.nixos; [
      gwen
    ];

    home-manager.users.gwen = {
      ###
    };
  };
}