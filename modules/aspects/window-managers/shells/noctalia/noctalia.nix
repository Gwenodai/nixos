# Minimal desktop shell for Niri/Hyprland
# https://noctalia.dev/
{
  inputs,
  den,
  ...
}:
{
  flake-file.inputs.noctalia = {
    url = "github:noctalia-dev/noctalia";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  ### Noctalia Class Policy
  den.policies.noctalia-to-homeManager = _: [
    (den.lib.policy.route {
      fromClass = "noctalia";
      intoClass = "homeManager";
      path = [
        "programs"
        "noctalia"
      ];
    })
  ];

  den.aspects.noctalia = {
    includes = [
      den.policies.noctalia-to-homeManager
    ];

    homeManager =
      { lib, ... }:
      {
        imports = [ inputs.noctalia.homeModules.default ];

        programs.noctalia = {
          enable = true;
          systemd.enable = true;
        };
      };

    ## Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/noctalia"
          {
            directory = "${hmConfig.xdg.cacheHome}/noctalia";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.cache/cliphist"
          {
            directory = "${hmConfig.xdg.cacheHome}/cliphist";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.local/state/noctalia"
          {
            directory = "${hmConfig.xdg.stateHome}/noctalia";
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
        # "~/.local/state"
        "${hmConfig.xdg.stateHome}" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/local/share/qalculate"
          "${hmConfig.xdg.dataHome}/qalculate"
        ];
      };
  };
}
