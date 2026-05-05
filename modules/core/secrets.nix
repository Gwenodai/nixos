# Atomic secret provisioning for NixOS based on sops
{
  inputs,
  den,
  self,
  ...
}:
{
  # Flake inputs
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Include sops-nix by default in all hosts and hm-users
  den.ctx.host.includes = [ den.aspects.secrets._.sys ];
  den.ctx.hm-user.includes = [ den.aspects.secrets._.hmUser ];

  # Declare a common sops file using meta-data which can be accessed by all aspects
  flake.lib.secrets.commonSopsFile = "${self + "/secrets/common/secrets.yaml"}";

  den.aspects.secrets = {
    # ---NixOS module--- #
    _.sys = den.lib.perHost {
      nixos =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          # Import the secrets module
          imports = [ inputs.sops-nix.nixosModules.sops ];

          environment.systemPackages = with pkgs; [
            age
            sops
            ssh-to-age
          ];

          sops = {
            age.sshKeyPaths = lib.mkDefault [ "/etc/ssh/ssh_host_ed25519_key" ];
            defaultSopsFile = lib.mkDefault inputs.self.lib.secrets.commonSopsFile;
          };
        };
    };

    # ---Home module--- #
    _.hmUser = den.lib.perUser {
      homeManager =
        { config, lib, ... }:
        {
          imports = [ inputs.sops-nix.homeManagerModules.sops ];

          sops = {
            age.sshKeyPaths = lib.mkDefault [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
            defaultSopsFile = lib.mkDefault (self + "/secrets/${config.home.username}/secrets.yaml");
          };
        };
    };
  };
}
