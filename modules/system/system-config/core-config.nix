{
  den,
  lib,
  ...
}: {
  den.aspects.system-config = {
    # Required core config for all hosts
    provides.core-config = {
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

        system.stateVersion = lib.mkDefault "25.11";
        nixpkgs.config.allowUnfree = lib.mkDefault true;
        # Silence the first time sudo warning
        security.sudo.extraConfig = ''
          Defaults lecture = "never"
        '';
        # users.mutableUsers = lib.mkDefault false;
      };
    };
  };


  den.ctx.host.includes = [
    # Provides core nixos configuration to all hosts
    den.aspects.system-config.provides.core-config
  ];
}
