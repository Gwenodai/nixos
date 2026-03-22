{ den, ... }: {
  # `core-config` is used by all hosts by default
  den.ctx.host.includes = [ den.aspects.nix-config._.core-config ];

  den.aspects.nix-config = {
    includes = with den.aspects.nix-config._; [
      garbage-collection
      locale
    ];

    # Required core config for all hosts
    _.core-config = den.lib.perHost {
      nixos = { lib, ... }: {
        nix.settings = {
          # Enable flakes
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          # Add `wheel` to trusted users
          trusted-users = [ "@wheel" ];
        };

        system.stateVersion = lib.mkDefault "25.11";
        nixpkgs.config.allowUnfree = lib.mkDefault true;
        # Silence the first time sudo warning
        security.sudo.extraConfig = ''
          Defaults lecture = "never"
        '';
        users.mutableUsers = lib.mkDefault false;
      };
    };

    _.garbage-collection = den.lib.perHost {
      nixos = { lib, ... }: {
        nix.gc = {
          automatic = lib.mkDefault true;
          dates = lib.mkDefault "weekly";
          options = lib.mkDefault "--delete-older-than 30d";
        };
        # Hard link identical files to save space
        nix.settings.auto-optimise-store = lib.mkDefault true;
      };
    };

    _.locale = den.lib.perHost {
      nixos = { lib, ... }: {
        time.timeZone = lib.mkDefault "Australia/Sydney";
        i18n.defaultLocale = lib.mkDefault "en_AU.UTF-8";
        console.keyMap = lib.mkDefault "us";
      };
    };
  };
}
