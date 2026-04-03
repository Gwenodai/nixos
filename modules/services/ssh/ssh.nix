{ den, ... }: {
  # Include ssh by default in all hosts
  den.ctx.host.includes = [ den.aspects.ssh ];

  den.aspects.ssh = {
    includes = with den.aspects.ssh._; [ openssh ];

    _.openssh = den.lib.perHost {
      nixos = { lib, ... }: {
        services.openssh = {
          enable = lib.mkDefault true;
          openFirewall = lib.mkDefault true;
          generateHostKeys = lib.mkDefault false;
          settings = {
            PermitRootLogin = lib.mkDefault "no";
            PasswordAuthentication = lib.mkDefault false;
            KbdInteractiveAuthentication = lib.mkDefault false;
          };
        };
      };

      persist = { lib, ... }: {
        files = lib.map (path: {
          file = path;
          how = "symlink";
          inInitrd = true; # Needed for `sops-nix`
          configureParent = true;
        }) [
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
        ];
      };

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
