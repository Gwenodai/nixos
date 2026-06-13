# Minimal desktop shell for Niri/Hyprland
# https://noctalia.dev/
{
  inputs,
  den,
  ...
}:
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.6";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ### Noctalia Class Policy
  den.policies.noctalia-to-homeManager = _: [
    (den.lib.policy.route {
      fromClass = "noctalia";
      intoClass = "homeManager";
      path = [
        "programs"
        "noctalia-shell"
      ];
    })
  ];

  den.aspects.noctalia = {
    includes = [
      den.policies.noctalia-to-homeManager
    ];

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
