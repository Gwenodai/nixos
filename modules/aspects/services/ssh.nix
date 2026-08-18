{
  den.aspects = {
    ssh = {
      nixos =
        {
          host,
          network-backends,
          lib,
          ...
        }:
        {
          services.openssh = {
            enable = true;
            openFirewall = true;
            generateHostKeys = false;
            settings = {
              PermitRootLogin = "no";
              PasswordAuthentication = false;
              KbdInteractiveAuthentication = false;
            };

            knownHosts = lib.listToAttrs (
              lib.map
                (entry: {
                  name = entry.source.host.name;
                  value = {
                    hostNames = [
                      entry.source.host.name
                      entry.value.ip
                    ];
                    publicKey = entry.value.publicKey;
                  };
                })
                # TODO: temporarily ignore ymir until the host is fully configured
                (
                  lib.filter (
                    entry: entry.source.host.name != host.name && entry.source.host.name != "ymir"
                  ) network-backends
                )
              # (lib.filter (entry: entry.source.host.name != host.name) network-backends)
            );
          };
        };

      homeManager = {
        programs.ssh = {
          enable = true;
          # This option will become deprecated in the future
          enableDefaultConfig = false;
          # So we disable it and manually recreate the old defaults
          settings = {
            "*" = {
              forwardAgent = false;
              addKeysToAgent = "no";
              compression = false;
              serverAliveInterval = 0;
              serverAliveCountMax = 3;
              hashKnownHosts = false;
              userKnownHostsFile = "~/.ssh/known_hosts";
              controlMaster = "no";
              controlPath = "~/.ssh/master-%r@%n:%p";
              controlPersist = "no";
            };
          };
        };
      };

      ### Persist config
      persist =
        { lib, ... }:
        {
          files =
            lib.map
              (path: {
                file = path;
                how = "symlink";
                inInitrd = true; # Needed for `sops-nix`
                configureParent = true;
              })
              [
                "/etc/ssh/ssh_host_ed25519_key"
                "/etc/ssh/ssh_host_ed25519_key.pub"
                "/etc/ssh/ssh_host_rsa_key"
                "/etc/ssh/ssh_host_rsa_key.pub"
              ];
        };

      persistUser = {
        directories = [
          # "~/.ssh"
          {
            directory = ".ssh";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
      };
    };

    ssh.authorizedKeys =
      { user, ... }:
      {
        nixos.users.users.${user.userName} = {
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILmAgY1ugFGFSF8b47UM4ilNTT13V7SCbYo/VA9EyVq8 gwen@gwen-t1"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEscSg7Yo3cXMbfYQ6WcQi2XR5zFggK/pFLtsgpHT7L gwen@gwen-s23plus"
          ];
        };

        ### Persist config
        persistIgnore = {
          directories = [ "/etc/ssh/authorized_keys.d" ];
        };
      };
  };
}
