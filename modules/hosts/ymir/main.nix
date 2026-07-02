{
  self,
  den,
  ...
}:
let
  hostName = "ymir";
  system = "x86_64-linux";
in
{
  den.hosts.${system}.${hostName}.users = {
    gwen = { };
  };

  den.aspects = {
    ${hostName} =
      { host, ... }:
      {
        network-backends = { config, ... }: {
          hostName = config.networking.hostName;
          ip = "192.168.1.64";
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKO3VzqMSHdWwg9QH5qMuYjkDAgfmqzzncq7bBRAXm8 host@ymir";
        };

        nixos = {
          # Set the default secrets file for this host
          sops.defaultSopsFile = "${self}/secrets/gwen.yaml";
        };

        includes = with den.aspects; [
          #---Boot & Kernel---#
          # Use systemd boot
          systemd-boot

          #---System Profile Base---#
          # Use the basic system type for now
          system-type.basic
        ];
      };

    gwen.provides.${hostName} = {
      includes = [
      ];
    };
  };
}
