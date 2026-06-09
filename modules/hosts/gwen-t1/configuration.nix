# Host system config
{
  self,
  den,
  ...
}:
{
  den.aspects.gwen-t1 =
    { host, ... }:
    {
      includes = with den.aspects; [
        ### Persistence
        # Opt into system wide ephemeral state management
        preservation

        ### System Config
        # Use systemd boot
        systemd-boot
        # Use the CachyOS kernel
        kernel.cachyos
        # Custom driver for MB fan control (needed for AIO control)
        kernel-modules.it87

        ### System-Type
        # Use the gaming desktop system preset
        system-type.desktop-gaming
        # Use the Niri desktop preset
        environment.niri

        ### Services
        valent

        ### Applications
        kitty
        nemo
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
        ## Debug
        dconf-editor
      ];

      provides = {
        gwen = {
          includes = [
            den.batteries.primary-user
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
