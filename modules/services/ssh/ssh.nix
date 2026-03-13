{ den, ... }: {
  den.aspects.ssh = {
    includes = with den.aspects.ssh.provides; [ openssh ];

    provides.openssh = {
      nixos = { lib, ... }: {
        services.openssh = {
          enable = lib.mkDefault true;
          openFirewall = lib.mkDefault true;
          settings = {
            PermitRootLogin = lib.mkDefault "no";
            PasswordAuthentication = lib.mkDefault true;
          };
        };
      };

      persist.files = map (path: {
        file = path;
        how = "symlink";
        inInitrd = true; # Needed for `sops-nix` user password
        configureParent = true;
      }) [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];

      persistUser.directories = [
        {
          directory = ".ssh";
          how = "symlink";
          mode = "0700";
          createLinkTarget = true;
        }
      ];
    };
  };
}
