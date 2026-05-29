{
  den.aspects.nix = {
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
}
