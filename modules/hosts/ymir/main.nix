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
