{ den, ... }:
let
  core-config = {
    nixos = {
      nix.settings = {
        # Enable flakes
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        # Add `wheel` to trusted users
        trusted-users = [ "@wheel" ];
      };

      system.stateVersion = "25.11";
      nixpkgs.config.allowUnfree = true;
      # Silence the first time sudo warning
      security.sudo.extraConfig = ''
        Defaults lecture = "never"
      '';
      users.mutableUsers = false;
    };
  };

  garbage-collection = {
    nixos = {
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      # Hard link identical files to save space
      nix.settings.auto-optimise-store = true;
    };
  };

  locale = {
    nixos = {
      time.timeZone = "Australia/Sydney";
      i18n.defaultLocale = "en_AU.UTF-8";
      console.keyMap = "us";
    };
  };
in
{
  den.aspects.nix-config.includes = [
    core-config
    garbage-collection
    locale
  ];
}
