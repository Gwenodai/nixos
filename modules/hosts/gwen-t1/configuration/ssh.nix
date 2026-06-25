{ inputs, ... }:
let
  hostName = "gwen-t1";
in
{
  # Host metadata for global use
  # TODO: Port public host metadata to den's quirk/pipe system
  flake.lib.hosts.${hostName} = {
    ip = "192.168.1.37";
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAJ1rnquy24cUcTB0c/B/2sYTsH+TzHRcIYcqRciQIu host@gwen-t1";
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
