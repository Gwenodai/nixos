# Niri window manager
# https://github.com/niri-wm/niri
{
  inputs,
  ...
}: {
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

    # systemd.user.services.niri-flake-polkit.enable = false;
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.niri = {
    config,
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      package = lib.mkDefault pkgs.niri;

      settings = {
        xwayland-satellite = {
          enable = lib.mkDefault true;
          path = lib.mkDefault "${(lib.getExe pkgs.xwayland-satellite)}";
        };
      };
    };
  };
}
