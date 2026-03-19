# Minimal desktop shell for Niri/Hyprland
# https://noctalia.dev/
{ inputs, den, ... }: {
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
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

  den.aspects.noctalia._.enable = den.lib.perUser {
    homeManager = { config, pkgs, lib, ... }: let
      # Small application to easily show changed values from live noctalia settings
      noctalia-diff = pkgs.writeShellApplication {
        name = "noctalia-diff";
        runtimeInputs = [
          pkgs.bat-extras.batdiff # Provides batdiff
          pkgs.jq                 # Provides jq
        ];
        text = lib.replaceStrings ["# syntax: bash\n"] [""] ''
          # syntax: bash
          batdiff <(jq -S . "${config.xdg.configHome}/noctalia/settings.json") \
          <(noctalia-shell ipc call state all | jq -S .settings)
        '';
      };
    in {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia-shell = {
        enable = lib.mkDefault true;
        # Run noctalia via systemd instead of manually within niri/hyprland
        systemd.enable = lib.mkDefault true;
      };
      home.packages = [ noctalia-diff ];
    };

    persistUser = { hmConfig, ... }: {
      directories = [
        "${hmConfig.xdg.cacheHome}/noctalia"
        "${hmConfig.xdg.cacheHome}/noctalia-qs"
        { directory = "${hmConfig.xdg.cacheHome}/cliphist"; mode = "0700"; }
        {
          directory = "${hmConfig.xdg.configHome}/noctalia/colorschemes";
          how = "symlink";
          createLinkTarget = true;
        }
      ];
    };

     persistUserTmp = { hmConfig, ... }: {
      "${hmConfig.xdg.cacheHome}" = {};  # "~/.cache"
      "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      "${hmConfig.xdg.configHome}/noctalia" = {};
    };
  };
}