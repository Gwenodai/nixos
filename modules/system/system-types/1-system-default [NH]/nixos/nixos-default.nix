{ ... }:

{
  # Default settings needed for all NixOS configurations

  flake.modules.nixos.system-default = {
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.05";

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
  };
}