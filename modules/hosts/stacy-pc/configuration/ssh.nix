{ inputs, ... }:
let
  hostName = "stacy-pc";
in
{
  # Host metadata for global use
  # TODO: Port public host metadata to den's quirk/pipe system
  flake.lib.hosts.${hostName} = {
    ip = "192.168.1.92";
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGKvThXtl26G7nOsGPtJC82cGGMFjLtQHYuzlHZM7xi8 root@stacy-pc";
  };

  den.aspects.ssh = {
    nixos.services.openssh.knownHosts.${hostName} = {
      hostNames = [
        hostName
        inputs.self.lib.hosts.${hostName}.ip
      ];
      publicKey = inputs.self.lib.hosts.${hostName}.publicKey;
    };
  };
}
