# Atomic secret provisioning for NixOS based on sops
{
  inputs,
  self,
  den,
  ...
}:
let
  hostConfig = {
    nixos =
      {
        pkgs,
        lib,
        ...
      }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        environment.systemPackages = with pkgs; [
          age
          sops
          ssh-to-age
        ];

        sops = {
          age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
          defaultSopsFile = lib.mkDefault inputs.self.lib.secrets.commonSopsFile;
        };
      };
  };

  userConfig = {
    homeManager =
      { config, lib, ... }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops = {
          age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
          defaultSopsFile = lib.mkDefault (self + "/secrets/${config.home.username}/secrets.yaml");
        };
      };
  };

in
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Declare a common sops file using meta-data which can be accessed by all aspects
  flake.lib.secrets.commonSopsFile = "${self + "/secrets/common/secrets.yaml"}";

  den.aspects.secrets.includes = [
    hostConfig
    userConfig
  ];
}
