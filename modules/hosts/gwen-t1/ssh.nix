{ inputs, den, ... }:
{
  den.aspects.ssh._.openssh = den.lib.perHost {
    nixos.services.openssh.knownHosts.gwen-t1 = {
      hostNames = [
        "gwen-t1"
        "${inputs.self.lib.hosts.gwen-t1.ip}"
      ];
      publicKey = inputs.self.lib.hosts.gwen-t1.publicKey;
    };
  };
}
