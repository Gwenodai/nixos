{
  den.default = {
    nixos = {
      system.stateVersion = "25.11";
      nixpkgs.config.allowUnfree = true;
      
      nix.settings = {
        # Enable Flakes and the new command-line tool        
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

      users.mutableUsers = false;

      networking.useDHCP = true;
    };
    
    homeManager = {
      home.stateVersion = "25.11";
    };
  };
}
