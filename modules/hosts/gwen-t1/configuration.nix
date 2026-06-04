# Host system config
{
  self,
  den,
  ...
}:
{
  den.aspects.gwen-t1 = {
    includes = with den.aspects; [
      ### Persistence
      preservation # Opt into system wide ephemeral state management

      ### System Config
      systemd-boot # Use systemd boot
      kernel.cachyos # Use the CachyOS kernel instead of the NixOS kernel
      kernel-modules.it87 # Driver for MB fan control (needed for AIO)

      ### System-Type
      system-type.desktop-gaming # Use the gaming desktop system preset
      environment.niri # Use the Niri desktop preset

      ### Services
      valent

      ### Applications
      google-chrome
      vscode
      vscode.config
      ## Messaging
      vesktop
      vesktop.config
      caprine
      ## Gaming
      steam
      heroic
      heroic.config
      ## Music
      spotify
    ];

    provides = {
      gwen = {
        includes = with den.aspects; [
          ### User Config
          den.batteries.primary-user

          ### Applications
          dconf-editor
        ];
      };
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
