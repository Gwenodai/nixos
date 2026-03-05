# Niri window manager
# https://github.com/niri-wm/niri
{
  inputs,
  ...
}: {
  # Convenience function to set Niri settings
  # only if the Niri module was imported
  flake.lib = {
    mkIfNiri= {
      options,
      ...
    }: input:
      if ( options ? home && options.programs ? niri ) then
        input # If the `niri` option is present, the input is valid
      else
        { };  # else we replace it with nothing
  };

  # --- NIXOS MODULE ---
  flake.modules.nixos.niri = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.niri.nixosModules.niri
    ];
    
    programs.niri = {
      package = lib.mkDefault pkgs.niri;
      enable = lib.mkDefault true;
    };
    
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    systemd.user.services.niri-flake-polkit.enable = false;
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      package = lib.mkDefault pkgs.niri;

      settings = {
        xwayland-satellite = {
          enable = lib.mkDefault true;
          path = lib.mkDefault "${lib.getExe pkgs.xwayland-satellite}";
        };
      };
    };

    xdg.portal.config.niri = {
      default = lib.mkDefault [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = lib.mkDefault [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = lib.mkDefault [ "gnome" ];
      "org.freedesktop.impl.portal.FileChooser" = lib.mkDefault [ "gtk" ];
    };
  };
}
