{ inputs, den, ... }:
let
  knownHost = {
    nixos.services.openssh.knownHosts.stacy-pc = {
      hostNames = [
        "stacy-pc"
        "${inputs.self.lib.hosts.stacy-pc.ip}"
      ];
      publicKey = inputs.self.lib.hosts.stacy-pc.publicKey;
    };
  };
in
{
  den.aspects.ssh.includes = [
    knownHost
  ];
}
