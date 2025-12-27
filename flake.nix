{
  description = "NixOS configuration";

  # Inputs: Sources for packages and modules
  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home & Theming
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # # Window Manager & Extensions
    # niri = {
    #   url = "github:sodiboo/niri-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  # Outputs: The resulting system configurations
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # This function creates a system profile so we don't have to repeat code.
    mkSystem = {
      hostname,
      username,
      system ? "x86_64-linux"
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        # Pass 'inputs' and 'username' to all NixOS modules so we can use them there
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          # Host specific config
          ./hosts/${hostname}
          # Common system config (timezone, locale, etc.)
          ./modules/common.nix
          # Stylix Module
          inputs.stylix.nixosModules.stylix
          # Home Manager setup
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # Pass inputs to Home Manager modules as well
            home-manager.extraSpecialArgs = {
              inherit inputs username;
            };
            # This expects a folder: ./users/gwen/home.nix
            home-manager.users.${username} = import ./users/${username}/home.nix;
          }
        ];
      };
  in {
    nixosConfigurations = {
      # Desktop
      gwen-t1 = mkSystem {
        hostname = "gwen-t1";
        username = "gwen";
      };
      # # Server
      # my-server = mkSystem {
      #   hostname = "my-server";
      #   username = "admin";
      # };
    };
  };
}