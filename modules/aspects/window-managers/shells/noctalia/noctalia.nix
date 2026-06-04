# Minimal desktop shell for Niri/Hyprland
# https://noctalia.dev/
{
  inputs,
  lib,
  den,
  ...
}:
let
  class =
    { class, aspect-chain }:
    den.batteries.forward {
      each = lib.singleton true;
      fromClass = _: "noctalia";
      intoClass = _: "homeManager";
      intoPath = _: [
        "programs"
        "noctalia-shell"
      ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
    };
in
{
  flake-file.inputs.noctalia = {
    url = "github:noctalia-dev/noctalia-shell/v4.7.6";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.noctalia-qs.follows = "noctalia-qs";
  };

  flake-file.inputs.noctalia-qs = {
    url = "github:noctalia-dev/noctalia-qs";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.noctalia = {
    includes = [ class ];

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

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/noctalia"
          "${hmConfig.xdg.cacheHome}/noctalia"
          # "~/.cache/noctalia-qs"
          "${hmConfig.xdg.cacheHome}/noctalia-qs"
          # "~/.cache/cliphist"
          {
            directory = "${hmConfig.xdg.cacheHome}/cliphist";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.config/noctalia/colorschemes"
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
        # "~/.cache"
        "${hmConfig.xdg.cacheHome}" = { };
        # "~/.config/noctalia"
        "${hmConfig.xdg.configHome}" = { };
        "${hmConfig.xdg.configHome}/noctalia" = { };
      };
  };
}
