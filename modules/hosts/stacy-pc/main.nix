{
  self,
  den,
  ...
}:
let
  hostName = "stacy-pc";
  system = "x86_64-linux";
in
{
  den.hosts.${system}.${hostName}.users = {
    stacy = { };
  };

  den.aspects = {
    ${hostName} =
      { host, ... }:
      {
        nixos =
          { pkgs, ... }:
          {
            # Override the default secrets file for this host
            sops.defaultSopsFile = self + "/secrets/stacy/secrets.yaml";
            # Use the latest CachyOS kernel with Zen4/5 specific optimizations
            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
          };

        includes = with den.aspects; [
          #---Boot & Kernel---#
          # Use systemd boot
          systemd-boot
          # Use the CachyOS kernel
          kernel.cachyos

          #---System Profile Base---#
          # Use the gaming desktop system type
          system-type.desktop-gaming

          #---Scripts---#
          scripts.fix-camera
        ];
      };

    stacy.provides.${hostName} = {
      includes = with den.aspects; [
        #---Identity & Permissions---#
        # This is the primary user of this host
        den.batteries.primary-user

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
        valent

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
