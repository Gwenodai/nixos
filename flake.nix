{
  description = "NixOS configuration";

  # Inputs: Sources for packages and modules
  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # import-tree
    import-tree.url = "github:vic/import-tree";
    # Ephemeral state management
    preservation.url = "github:nix-community/preservation";
    # Secrets
    agenix = {
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
      };
      url = "github:ryantm/agenix";
    };
    # Flake splitting
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # # Theming
    # stylix = {
    #   url = "github:nix-community/stylix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # # Niri window manager
    # niri = {
    #   url = "github:sodiboo/niri-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      # Imports all of the top-level modules (the files under `./modules`)
      (inputs.import-tree ./modules);
}