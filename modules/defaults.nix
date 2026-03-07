{
  den,
  lib,
  ...
}: {
  # These are GLOBAL static settings
  den.default = {
    nixos.system.stateVersion = "25.11";
    homeManager.home.stateVersion = "25.11";
    nixpkgs.config.allowUnfree = true;
    
    nixos = {
      nix.settings = {    
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];
      };

      security.sudo.extraConfig = ''
        Defaults lecture = "never"
      '';
      
      # Temp stubs
      boot.loader.grub.enable = false;
      fileSystems."/".device = lib.mkDefault "/dev/fake";
    };
  };

  den.default.includes = [
    # ${user}.provides.${host} and ${host}.provides.${user}
    den.aspects.routes
    # Automatically create the user on host
    den.provides.define-user
    # Automatically set hostname based on host
    ( den.lib.take.exactly ( # TODO: Move to sepereate module
      { host }: { nixos.networking.hostName = host.hostName; }
    ))
  ];
}