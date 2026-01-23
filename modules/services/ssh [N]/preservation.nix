{
  flake.modules.nixos.ssh = {
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.preservation.enable {
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
}