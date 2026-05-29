# Host system config
{
  __findFile,
  self,
  den,
  ...
}:
let
  # Aspects shared by both the host and its users
  sharedAspects = with den.aspects; [
    # ---System Preset--- #
    <sys-preset-desktop>
    <sys-preset-desktop/gaming> # Use the gaming desktop system preset
    wm-preset-niri # Use the Niri desktop preset
  ];
in
{
  den.aspects.stacy-pc = {
    includes =
      with den.aspects;
      sharedAspects
      ++ [
        # ---Core Config--- #
        systemd-boot # Use systemd boot
        # Kernel config
        kernel.cachyos # Use the CachyOS kernel instead of the NixOS kernel
        # ---Services--- #
        valent

        # ---Scripts--- #
        scripts.fix-camera
      ];

    _.to-users = {
      includes =
        with den.aspects;
        sharedAspects
        ++ [
          # ---Applications--- #
          spotify
          caprine
        ];
    };

    _.stacy = {
      includes = [
        # ---User Config--- #
        den.batteries.primary-user
      ];
    };

    nixos =
      { lib, ... }:
      {
        # Set the default secrets file for this host
        sops.defaultSopsFile = self + "/secrets/stacy/secrets.yaml";
      };
  };
}
