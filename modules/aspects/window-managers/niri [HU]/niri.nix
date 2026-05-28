# Niri window manager
# https://github.com/niri-wm/niri
{
  inputs,
  den,
  lib,
  ...
}:
let
  getNiri = pkgs: pkgs.niri;

  hostConfig = {
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
  };

  userConfig = {
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

  class =
    { host, user }:
    { class, aspect-chain }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "niri";
      intoClass = _: "homeManager";
      intoPath = _: [
        "programs"
        "niri"
      ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
      # This `adapterModule` allows the following lists to append
      # rather than overwrite each other
      adapterModule =
        let
          listOption = lib.mkOption {
            type = lib.types.listOf lib.types.anything;
            default = [ ];
          };
          attrOption = lib.mkOption {
            type = lib.types.attrsOf lib.types.anything;
            default = { };
          };
        in
        {
          options.settings = {
            spawn-at-startup = listOption;
            window-rules = listOption;
            layer-rules = listOption;
            binds = attrOption;
          };
        };
    };
in
{
  flake-file.inputs.niri = {
    # url = "github:sodiboo/niri-flake";
    url = "github:cmm/niri-flake/add-extraConfig";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.niri.includes = [
    hostConfig
    userConfig
    class
  ];
}
