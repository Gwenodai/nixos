# Host system config
{
  self,
  den,
  ...
}:
let
  hostName = "gwen-t1";
in
{
  # den.hosts.x86_64-linux.gwen-t1.users.gwen = { };
  den.aspects = {
    ${hostName} =
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
        ];

        provides = {
          gwen =
            { user, ... }:
            {
              includes = [
                # den.batteries.primary-user
                # den.aspects.environment.niri
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

    gwen.provides.${hostName} = {
      includes = with den.aspects; [
        # Gwen is the primary user of this host
        den.batteries.primary-user

        ### User Environment
        environment.niri

        ### Services
        valent

        ### Applications
        kitty
        nemo
        google-chrome
        vscode
        vscode.config
        gnome-calendar
        ## Messaging
        vesktop
        vesktop.config
        caprine
        ## Music
        spotify
        ## Debug
        dconf-editor

        ### Gaming
        steam
        heroic
        heroic.config
        ## Mods
        mods.halo-wars.cameraZoom
      ];
    };

    stacy.provides.${hostName} = {
      includes = with den.aspects; [
        # environment.niri
      ];
    };
  };
}
