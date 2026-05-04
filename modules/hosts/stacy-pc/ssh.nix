{ inputs, den, ... }:
{
  den.aspects.ssh._.openssh = den.lib.perHost {
    nixos.services.openssh.knownHosts.stacy-pc = {
      hostNames = [
        "stacy-pc"
        "${inputs.self.lib.hosts.stacy-pc.ip}"
      ];
      publicKey = inputs.self.lib.hosts.stacy-pc.publicKey;
    };
  };
}
