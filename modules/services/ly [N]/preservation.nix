{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.nixos.ly = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      # Import the Home Manager module automatically
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.ly
      ];

      preservation.preserveAt."/persist" = {
        files = [
          {
            file = "/etc/ly/save.txt";
            mode = "0644";
          }
        ];
      };
    };
  };
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.ly = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation.ignore.files = [
        "ly-session.log"
      ];
    };
  };
}