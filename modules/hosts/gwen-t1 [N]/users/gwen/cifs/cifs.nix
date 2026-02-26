{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    ...
  }: {
    imports = with inputs.self.factory; [
      (
        mount-cifs-nixos {
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
        }
      )
    ];
  };
}