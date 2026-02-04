# Declare 'gwen' user for this host
{
  inputs,
  self,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    config,
    ...
  }: {
    imports =
      # nixos
      with inputs.self.modules.nixos;
      # factory
      with inputs.self.factory;
      [
        # nixos import
        gwen
      ];

    home-manager.users.gwen = {
      ###
    };
  };
}