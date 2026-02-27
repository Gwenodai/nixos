{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    ...
  }: {
    # --- HOME MANAGER MODULE ---
    home-manager.users.gwen = {
      options,
      config,
      ...
    }: {
      config = inputs.self.lib.mkIfNoctalia { inherit options; } {
        programs.noctalia-shell = {
          settings = {
            general = {
              lockScreenMonitors = [
                "HDMI-A-1"
              ];
            };
          };
        };
      };
    };
  };
}
