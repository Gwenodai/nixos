# Niri window manager
# https://github.com/niri-wm/niri
{
  inputs,
  den,
  ...
}:
let
  getNiri = pkgs: pkgs.niri;
in
{
  flake-file.inputs.niri = {
    # url = "github:sodiboo/niri-flake";
    url = "github:cmm/niri-flake/add-extraConfig";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  ### Niri Class Policy
  den.policies.niri-to-homeManager = _: [
    (den.lib.policy.route {
      fromClass = "niri";
      intoClass = "homeManager";
      path = [
        "programs"
        "niri"
      ];
    })
  ];

  den.aspects.niri = {
    includes = [
      den.policies.niri-to-homeManager
    ];

    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.niri.nixosModules.niri ];

        programs.niri = {
          enable = true;
          package = getNiri pkgs;
        };
        systemd.user.services.niri-flake-polkit.enable = false;
      };

    homeManager =
      { pkgs, lib, ... }:
      {
        programs.niri = {
          package = getNiri pkgs;

          settings = {
            xwayland-satellite = {
              enable = true;
              path = "${lib.getExe pkgs.xwayland-satellite}";
            };
          };
        };

        xdg.portal.config.niri = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
      };
  };
}
