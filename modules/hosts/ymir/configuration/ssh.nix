{ inputs, ... }:
let
  hostName = "ymir";
in
{
  # Host metadata for global use
  # TODO: Port public host metadata to den's quirk/pipe system
  flake.lib.hosts.${hostName} = {
    ip = "192.168.1.64";
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKO3VzqMSHdWwg9QH5qMuYjkDAgfmqzzncq7bBRAXm8 root@ymir";
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
