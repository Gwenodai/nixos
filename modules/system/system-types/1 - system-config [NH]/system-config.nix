# Core system config needed for all systems
{ ... }: {
  flake.modules.nixos.system-config = {
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11";

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
  };

  flake.modules.homeManager.system-config = {
    config,
    ...
  }: {
    home.homeDirectory = "/home/${config.home.username}";
    home.stateVersion = "25.11";
  };
}