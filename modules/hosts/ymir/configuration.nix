# Host system config
{
  self,
  den,
  ...
}:
let
  # Aspects shared by both the host and its users
  sharedAspects = with den.aspects; [
    ### System Preset
    system-type.basic
  ];
in
{
  den.aspects.ymir = {
    includes =
      with den.aspects;
      sharedAspects
      ++ [
        ### Core Config
        systemd-boot # Use systemd boot
      ];

    _.to-users = {
      includes = with den.aspects; sharedAspects ++ [ ];
    };

    _.gwen = {
      includes = [
        ### User Config
        den.batteries.primary-user
      ];
    };

    nixos =
      { lib, ... }:
      {
        # Set the default secrets file for this host
        sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
        fileSystems."/".device = lib.mkDefault "/dev/fake"; # FIXME: Temp stub
      };
  };
}
