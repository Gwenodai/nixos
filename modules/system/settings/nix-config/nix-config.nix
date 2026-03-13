{ den, ... }: {
  # These configs are used by all hosts by default
  den.ctx.host.includes = [ den.aspects.nix-config.provides.core-config ];

  den.aspects.nix-config = {
    includes = with den.aspects.nix-config.provides; [
      garbage-collection
      locale
    ];

    # Required core config for all hosts
    provides.core-config = den.lib.take.exactly ({ host }: {
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
        # users.mutableUsers = lib.mkDefault false;
      };
    });

    provides.garbage-collection = den.lib.take.exactly ({ host }: {
      nixos = { lib, ... }: {
        nix.gc = {
          automatic = lib.mkDefault true;
          dates = lib.mkDefault "weekly";
          options = lib.mkDefault "--delete-older-than 30d";
        };
        # Hard link identical files to save space
        nix.settings.auto-optimise-store = lib.mkDefault true;
      };
    });

    provides.locale = den.lib.take.exactly ({ host }: {
      nixos = { lib, ... }: {
        time.timeZone = lib.mkDefault "Australia/Sydney";
        i18n.defaultLocale = lib.mkDefault "en_AU.UTF-8";
        console.keyMap = lib.mkDefault "us";
      };
    });
  };
}
