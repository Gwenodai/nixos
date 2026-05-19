{ inputs, den, ... }:
let
  knownHost = den.lib.perHost {
    nixos.services.openssh.knownHosts.ymir = {
      hostNames = [
        "ymir"
        "${inputs.self.lib.hosts.ymir.ip}"
      ];
      publicKey = inputs.self.lib.hosts.ymir.publicKey;
    };
  };
in
{
  den.aspects.ssh.includes = [
    knownHost
  ];
}
