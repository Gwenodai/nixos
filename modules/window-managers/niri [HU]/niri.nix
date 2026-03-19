# Niri window manager
# https://github.com/niri-wm/niri
{ inputs, den, ... }: {
  flake-file.inputs.niri = {
    # url = "github:sodiboo/niri-flake";
    url = "github:cmm/niri-flake/add-extraConfig";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.niri._.enable = den.lib.perHost {
    nixos = { pkgs, lib, ... }: {
      imports = [ inputs.niri.nixosModules.niri ];
      
      programs.niri = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgs.niri;
      };
      environment.systemPackages = with pkgs; [ xwayland-satellite ];
      systemd.user.services.niri-flake-polkit.enable = lib.mkDefault false;
    };
  };
}