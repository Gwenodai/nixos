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
    # ---Core Aspects--- #
    persist # Opt into system wide ephemeral state management

    # ---System Preset--- #
    <sys-preset-desktop>
    <sys-preset-desktop/gaming> # Use the gaming desktop system preset
    wm-preset-niri # Use the Niri desktop preset
  ];
in
{
  den.aspects.gwen-t1 = {
    includes =
      with den.aspects;
      sharedAspects
      ++ [
        # ---Persistence--- #
        <persist/minimal-preset> # Use preconfigured default settings for preservation
        <persist/find-ephemeral> # Tool to locate files not currently preserved

        # ---System Config--- #
        systemd-boot # Use systemd boot
        # Kernel config
        <kernel/cachyos> # Use the CachyOS kernel instead of the NixOS kernel
        <kernel-modules/it87> # Driver for MB fan control (needed for AIO)
        # CPU config
        <amdcpu>
        <amdcpu/performance>
        # GPU config
        <amdgpu>
        <amdgpu/overclock>

        # ---Services--- #
        valent
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

    _.gwen = {
      includes = with den.aspects; [
        # ---User Config--- #
        <den/primary-user>

        # ---Applications--- #
        dconf-editor
      ];
    };

    nixos =
      { pkgs, lib, ... }:
      {
        # Set the default secrets file for this host
        sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";

        ### Logitech G703 mouse
        # hardware.logitech.wireless.enable = true;
        # hardware.logitech.wireless.enableGraphical = true;
        # environment.systemPackages = [ pkgs.piper ];
        # services.ratbagd.enable = true;
      };
  };
}
