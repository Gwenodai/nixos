{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    config,
    lib,
    ...
  }: {
    config = lib.mkIf ( config.programs.niri.enable or false ) {
      # --- HOME MANAGER MODULE ---
      home-manager.users.gwen = {
        ...
      }: {
        programs.niri.settings.outputs = {
          "Philips Consumer Electronics Company PHILIPS FTV 0x01010101" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.000;
            };
            position = {
              x = -1920;
              y = 180;
            };
            scale = 1;
          };
        };
      };
    };
  };
}
