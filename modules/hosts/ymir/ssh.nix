{ inputs, den, ... }:
{
  den.aspects.ssh._.openssh = den.lib.perHost {
    nixos.services.openssh.knownHosts.ymir = {
      hostNames = [
        "ymir"
        "${inputs.self.lib.hosts.ymir.ip}"
      ];
      publicKey = inputs.self.lib.hosts.ymir.publicKey;
    };
  };
}
