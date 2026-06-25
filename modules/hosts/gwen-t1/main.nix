{
  self,
  den,
  ...
}:
let
  hostName = "gwen-t1";
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
        nixos =
          { pkgs, ... }:
          {
            # Set the default secrets file for this host
            sops.defaultSopsFile = "${self}/secrets/gwen.yaml";
            # Use the latest CachyOS kernel with Zen4/5 specific optimizations
            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
          };

        includes = with den.aspects; [
          #---Boot & Kernel---#
          # Use systemd boot
          systemd-boot
          # Use the CachyOS kernel
          kernel.cachyos
          # Custom driver for MB fan control (needed for AIO control)
          kernel-modules.it87

          #---Storage & Persistence---#
          # Opt into system wide ephemeral state management
          preservation

          #---System Profile Base---#
          # Use the gaming desktop system type
          system-type.desktop-gaming
        ];
      };

    gwen.provides.${hostName} = {
      includes = with den.aspects; [
        #---Desktop Environment Base---#
        environment.niri

        #---Core Desktop Apps---#
        kitty
        nemo
        file-roller
        google-chrome
        vscode
        vscode.config
        gnome-calendar

        #---Communication---#
        vesktop
        vesktop.config
        caprine

        #---Media & Background Services---#
        spotify
        vlc
        valent
        # kde-connect
        dconf-editor

        #---Gaming---#
        ## Launchers
        steam
        heroic
        heroic.config
        ## Mods & Mod Tools
        mods.halo-wars.cameraZoom
      ];
    };
  };
}
