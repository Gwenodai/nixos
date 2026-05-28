{ den, ... }:
let
  hostConfig = {
    nixos = {
      services.openssh = {
        enable = true;
        openFirewall = true;
        generateHostKeys = false;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
    };

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
  };

  userConfig = {
    homeManager = {
      programs.ssh = {
        enable = true;
        # This option will become deprecated in the future
        enableDefaultConfig = false;
        # So we disable it and manually recreate the old defaults
        matchBlocks."*" = {
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

    persistUser.directories = [
      {
        directory = ".ssh";
        how = "symlink";
        mode = "0700";
        createLinkTarget = true;
      }
    ];
  };
in
{
  den.aspects.ssh.includes = [
    hostConfig
    userConfig
  ];
}
