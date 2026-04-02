# Atomic secret provisioning for NixOS based on sops
{ inputs, den, self, ... }: {
  # Flake inputs
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Include sops-nix by default in all hosts and hm-users
  den.ctx.host.includes = [ den.aspects.secrets._.secretsNix ];
  den.ctx.hm-user.includes = [ den.aspects.secrets._.secretsHome ];

  # Declare a common sops file using meta-data which can be accessed by all aspects
  den.schema.conf = { lib, ... }: {
    options.sops.commonSopsFile = lib.mkOption {
      default = (self + "/secrets/common/secrets.yaml");
    };
  };

  den.aspects.secrets = {
    # ---NixOS module--- #
    _.secretsNix = den.lib.perHost ({ host }: {
      nixos = { config, pkgs, lib, ... }: {
        # Import the secrets module
        imports = [ inputs.sops-nix.nixosModules.sops ];

        environment.systemPackages = with pkgs; [
          age
          sops
          ssh-to-age
        ];
        
        sops = {
          age.sshKeyPaths = lib.mkDefault [ "/etc/ssh/ssh_host_ed25519_key" ];
          defaultSopsFile = lib.mkDefault host.sops.commonSopsFile;
        };
      };
    });

    # ---Home module--- #
    _.secretsHome = den.lib.perUser {
      homeManager = { config, lib, ... }: {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops = {
          age.sshKeyPaths = lib.mkDefault [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
          defaultSopsFile =
            lib.mkDefault (self + "/secrets/${config.home.username}/secrets.yaml");
        };
      };

      # ---Persist config--- #
      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/sops";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };
      persistUserTmp = { hmConfig, ... }: {
        "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      };
    };
  };
}