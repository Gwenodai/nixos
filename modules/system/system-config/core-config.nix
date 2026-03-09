{
  den,
  lib,
  ...
}: {
  den.ctx.host.includes = [
    # Provides core nixos configuration to all hosts
    den.aspects.system-config.provides.core-config
  ];

  den.aspects.system-config = {
    provides.core-config = {
      nixos = {
        nix.settings = {    
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-users = [ "@wheel" ];
        };

        system.stateVersion = lib.mkDefault "25.11";
        nixpkgs.config.allowUnfree = lib.mkDefault true;
        security.sudo.extraConfig = ''
          Defaults lecture = "never"
        '';
        # users.mutableUsers = lib.mkDefault false;
      };
    };
  };
}
