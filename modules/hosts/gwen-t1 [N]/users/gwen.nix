# Declare 'gwen' user for this host
{
  inputs,
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
        # factory import
        (mount-cifs-nixos {
          host = "192.168.1.64"; # TODO: Use predefined server cifs config
          resource = "Network-Storage";
          destination = "/mnt/x370/root";
          UID = "1000";
          GID = "1000";
          extraoptions = [
            "guest"
            "noperm"
            "nounix"
            "nobrl"
          ];
        })
      ];

    home-manager.users.gwen = {
      ###
    };
  };
}