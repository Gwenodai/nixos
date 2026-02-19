{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.ssh = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      # Import the Home Manager module automatically
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.ssh
      ];
      
      preservation = {
        preserveAt."/persist" = {
          files = map (x: {
            file = x;
            how = "symlink";
            configureParent = true;
          }) [
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
            "/etc/ssh/ssh_host_rsa_key"
            "/etc/ssh/ssh_host_rsa_key.pub"
          ];
        };
      };
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.ssh = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            {
              directory = ".ssh";
              how = "symlink";
              mode = "0700";
              createLinkTarget = true;
            }
          ];
        };
      };
    };
  };
}