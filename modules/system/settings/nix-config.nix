{ den, ... }: {
  # These configs are used by all hosts by default
  den.ctx.host.includes = with den.aspects.nix-config.provides; [
    core-config
    garbage-collection
    locale
  ];

  den.aspects.nix-config = {
    # Required core config for all hosts
    provides.core-config = {
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
    };

    provides.garbage-collection = {
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

    provides.locale = {
      nixos = { lib, ... }: {
        time.timeZone = lib.mkDefault "Australia/Sydney";
        i18n.defaultLocale = lib.mkDefault "en_AU.UTF-8";
        console.keyMap = lib.mkDefault "us";
      };
    };
  };
}
