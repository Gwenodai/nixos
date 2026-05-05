# Minimal desktop shell for Niri/Hyprland
# https://noctalia.dev/
{
  inputs,
  lib,
  den,
  ...
}:
let
  noctalia = den.lib.perUser {
    homeManager =
      { inputs', ... }:
      {
        imports = [ inputs.noctalia.homeModules.default ];

        programs.noctalia-shell = {
          enable = true;
          package = inputs'.noctalia.packages.default.override {
            calendarSupport = true;
          };
        };
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          "${hmConfig.xdg.cacheHome}/noctalia"
          "${hmConfig.xdg.cacheHome}/noctalia-qs"
          {
            directory = "${hmConfig.xdg.cacheHome}/cliphist";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
          {
            directory = "${hmConfig.xdg.configHome}/noctalia/colorschemes";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        "${hmConfig.xdg.cacheHome}" = { }; # "~/.cache"
        "${hmConfig.xdg.configHome}" = { }; # "~/.config"
        "${hmConfig.xdg.configHome}/noctalia" = { };
      };
  };

  class = den.lib.perUser (
    { host, user }:
    { class, aspect-chain }:
    den._.forward {
      each = lib.singleton user;
      fromClass = _: "noctalia";
      intoClass = _: "homeManager";
      intoPath = _: [
        "programs"
        "noctalia-shell"
      ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
    }
  );
in
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.6";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        noctalia-qs.follows = "noctalia-qs";
      };
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.noctalia.includes = [
    noctalia
    class
  ];
}
